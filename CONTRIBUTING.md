# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change.

## Contributing to the Documentation

The documentation was created with the [GitBook toolchain](https://toolchain.gitbook.com).

To contribute you can either request access to the [Gitbook online editor](https://www.gitbook.com/book/biocuriousdiylab/cuttlefishwranglin/details) or clone this repo and development locally and then submit a pull request.

### To Develop Locally

#### Prerequisites
* [Node.js](https://nodejs.org) v4.0.0 or higher

#### Installation

Install [GitBook](https://toolchain.gitbook.com/) CLI globally
```sh
 npm install gitbook-cli -g
```

#### Development
```sh
git clone https://github.com/BiocuriousDIYLab/CuttlefishWranglin.git
cd CuttlefishWranglin
gitbook install
gitbook serve
```

You can now access the documentation at: [http://localhost:4000](http://localhost:4000)

Open the project files in your favorite text editor and start contributing. [http://localhost:4000](http://localhost:4000) will refresh.


#### Opening a pull request
_The following is pulled from this [open source guide](https://opensource.guide/how-to-contribute/#opening-a-pull-request)_.

You should usually open a pull request in the following situations:
* Submit trivial fixes (ex. a typo, broken link, or obvious error)
* Start work on a contribution that was already asked for, or that you’ve already discussed, in an issue

A pull request doesn’t have to represent finished work. It’s usually better to open a pull request early on, so others can watch or give feedback on your progress. Just mark it as a “WIP” (Work in Progress) in the subject line. You can always add more commits later.

If the project is on GitHub, here’s how to submit a pull request:
* [Fork the repository](https://guides.github.com/activities/forking/) and clone it locally. Connect your local to the original “upstream” repository by adding it as a remote. Pull in changes from “upstream” often so that you stay up to date so that when you submit your pull request, merge conflicts will be less likely. (See more detailed instructions [here](https://help.github.com/articles/syncing-a-fork/).)
* [Create a branch](https://guides.github.com/introduction/flow/) for your edits.
* Reference any relevant issues or supporting documentation in your PR (ex. “Closes #37.”)
* Include screenshots of the before and after if your changes include differences in HTML/CSS. Drag and drop the images into the body of your pull request.
* Test your changes! Run your changes against any existing tests if they exist and create new ones when needed. Whether tests exist or not, make sure your changes don’t break the existing project.
* Contribute in the style of the project to the best of your abilities. This may mean using indents, semi-colons or comments differently than you would in your own repository, but makes it easier for the maintainer to merge, others to understand and maintain in the future.

If this is your first pull request, check out [Make a Pull Request](http://makeapullrequest.com/), which [@kentcdodds](@kentcdodds) created as a free walkthrough resource.
