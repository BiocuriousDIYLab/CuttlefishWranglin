# Dockerized tools

Bioinformatics tools can be picky about their build environments, so we've packaged up some tools in Docker images so
that they can each have their own userlands without conflicting with each other.

What this means in practice is if you have a software package that has annoying and/or crazy build system requirements,
you can isolate the badness to that particular package and not taint the rest of the system. Such pesky packages are
common in bioinformatics, so we're setting up Docker builds for the tools we need so people don't have to spew stuff all
over their main OS installs to use them.

Another benefit is that it means that we can all use the _exact_ same tools, down to the last byte. This means it will
be easier for anyone to reproduce our work, whether that's teammates troubleshooting a problem or someone trying to
reproduce a paper's results.

Each tool has its own `Dockerfile` in the corresponding subdirectory, and describes:

- Where its build output is in the resulting image. If you need to access files (binaries, config, etc) via a full path,
that's where to look.
- What, if any, directories are in the `PATH` environment variable inside the container. Binaries in these directories
will be accessible without specifying the full path, just like in your host OS.
- The `ENTRYPOINT`, if any. This is a Docker specific concept. If there's only one command to run for a particular tool,
that can be set as the default command to run if you run the Docker image without specifying any further args. In 
other words, if an image `some-image` is only ever used to run command `make-widgets`, it can be specified in the 
Dockerfile so you only have to do `docker run some-image` instead of `docker run some-image make-widgets`. If you need
to override this (e.g. for interactive exploration), use `--entrypoint`: `docker run --entrypoint /bin/bash some-image`.

## Tools

- `busco`: Build output in `/opt/busco`, e.g. `/opt/busco/scripts/run_BUSCO.py`. `PATH` includes `/opt/busco/scripts/`
and Augustus's `bin` and `scripts` directories. 
    - BUSCO is especially annoying in its config, and an output path had to be baked in to the config since you can't 
    provide it on the command line. The output path is set to `/data/` since that's where we guide people to mount a 
    volume in the container. If `/data` won't work for you, you can provide your own BUSCO config file (e.g. in `/data` 
    if you override the `BUSCO_CONFIG_FILE` env var with `-e` in your `docker run` command). See the 
    [BUSCO user guide](http://gitlab.com/ezlab/busco/raw/master/BUSCO_v3_userguide.pdf) for more details.
- `fastqc`: Build output installed in `/opt/FastQC`. `ENTRYPOINT` set to `fastqc`. 
    - Note that in certain modes it will try to open a GUI window, which won't work, but in the normal usage of passing
     it a few fastq files it won't do that.
- `meraculous`: Build output installed in `/opt/meraculous`. `PATH` includes `/opt/meraculous/bin`.
- `quast`: Build output installed in `/usr/local/bin`. `ENTRYPOINT` is `quast.py`.
- `spades`: Images available at [`biocurious/spades`](https://hub.docker.com/r/biocurious/spades/tags/). Build output
installed in `/opt/spades/`, e.g `/opt/spades/bin/spades.py`. `PATH` includes `/opt/spades/bin`.
- `sra-tools`: Images available at [`biocurious/sra-tools`](https://hub.docker.com/r/biocurious/sra-tools/tags/). 
Build output is installed to the default "all over the place" locations, e.g. `fastq-dump` in 
`/usr/local/ncbi/sra-tools/bin/fastq-dump`. `PATH` includes `/usr/local/ncbi/sra-tools/bin`.


## Using already built images

If there's an image that you want to run, like one of the ones from [BioCurious's repositories](https://hub.docker.com/u/biocurious/dashboard/), find the one you want, like `2.9.0` available in the [sra-tools repo](https://hub.docker.com/r/biocurious/sra-tools/tags/).

Because the organization is `biocurious`, the repo is `sra-tools`, and the tag is `2.9.0`, the image would be named `biocurious/sra-tools:2.9.0` and you would use it like so:

```
docker run <other docker args> biocurious/sra-tools:2.9.0 /usr/local/ncbi/sra-tools/bin/fastq-dump <fastq-dump args>
```

## Building images yourself

For each of the sibling directories with a `Dockerfile` in it, you can build it like so:

```
docker build -f abyss/Dockerfile .
```

That will output a bunch of stuff, ending in something like this:

```
Successfully built 06b350ac51ae
```

That bit of hex at the end is the *image id* that contains the files you care about (e.g. compiled software).

If you want to tag an image (e.g. to push to one of our repositories), see the section below about tagging.

## Running a temporary interactive container

To run a temporary container that throws away any changes made once the container exits, you would run:

```
docker run -i --rm -t <image id> bash
```

The options `-i` and `-t` set up the container for interactive shell usage, and `--rm`: remove the image generated by 
whatever work you do inside the shell. If you didn't have `--rm` your disk will gradually fill up with all the (useless)
 images generated by your interactive work.

That command will give you a root shell (`bash`, specifically) inside the image. You can poke around (`ls`, `cd`, etc) 
to satisfy yourself that the files you expect to have are there. If they aren't, maybe the Dockerfile isn't working, 
or isn't documented clearly, so file a bug or make a PR.

## Running commands from the host OS

Just an interactive shell with the contents of the image usually isn't what you want. You probably want to run an actual
command that's part of the software built by the Dockerfile. Fortunately, this is easy. Instead of `bash` in the 
example above, use the path *inside the image* of the command you want. In the case of `sra-tools`, for instance, 
it installs stuff in weird locations (remember, this is why we don't want this installed in our host OS), but we can 
still invoke it from the host OS:

```
docker run -i --rm -t biocurious/sra-tools:2.9.0 /usr/local/ncbi/sra-tools/bin/fastq-dump --help
```

That should show the help for `fastq-dump`, and of course you could run any other command the same way.

##  Accessing files inside containers
Dockerfiles have a way to include files in the resulting images, but it requires rebuilding the images every time you
change a file, so it's not really suited to the sort of data manipulation we want to do. It's oriented more towards
including source code or config, not large data files. What we want to do is use a *volume*, which is a way to have a
directory in the host OS that's also visible inside the container without copying the data. The same data is accessible
in both places.

First, create a directory in your host system. If you have a place you want to keep your large files (a big hard drive
or equivalent, `/big-volume` below), put the directory there.

```
mkdir /big-volume/bio-data
```

Then, run a command that downloads some data. Note that you must use the absolute path to the volume on your host OS's
filesystem.

```
docker run -i --rm -t -v /big-volume/bio-data:/data biocurious/sra-tools:2.9.0 \
    /usr/local/ncbi/sra-tools/bin/fastq-dump \
    --outdir /data \
    --gzip \
    --split-files \
    ERR1294016
```

That will take a long time to run. While it's running, you can use a different shell to check the progress of the
command by watching the files grow in `/big-volume/bio-data`.

When the command completes, the temporary container will go away, but the data will remain for you to use with
subsequent commands in `/big-volume/bio-data`.

## Tagging and pushing images to share on the `biocurious` repo

When you build an image with `docker build ...`, the image has an id like `3c9ea95afe0f`, and it only exists on your
machine. You could just ask other people to build an image themselves from the same `Dockerfile` you used, but it would
be nice to share the exact same image down to the last byte to know that you're getting the same behavior that someone
else is.

To make this possible, we have the [biocurious organization on Docker
Hub](https://hub.docker.com/u/biocurious/dashboard/). Inside that, we have repositories like
[sra-tools](https://hub.docker.com/r/biocurious/sra-tools/), which hosts the images for the `sra-tools` Dockerfile in
this repo.

First, build your Dockerfile.

```
docker build -f sra-tools/Dockerfile .
```

That will output something like:

```
Successfully built 3c9ea95afe0f
```
You should then manually test that running tools from `3c9ea95afe0f` is working ok. If everything is OK, tag the docker
image with a name that maps to the `biocurious/sra-tools` organization/repository pair.

```
docker tag 3c9ea95afe0f biocurious/sra-tools:2.9.0
```

The `2.9.0` is because the Dockerfile builds `sra-tools` 2.9.0. Confusingly, the `tag` command uses
`biocurious/sra-tools:2.9.0` as the tag, but also refers to just `2.9.0` as the "tag"... Docker is weird.

You can then push that tagged image to the corresponding repo. The image name must match the organization/repo/tag
structure. (Don't actually do this exact command; there's already a `biocurious/sra-tools:2.9.0` and you shouldn't
replace it.)

```
docker push biocurious/sra-tools:2.9.0
```
