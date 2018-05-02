# S3 buckets

The S3 buckets use the prefix `bioc-cf` for "BioCurious Cuttlefish". If you need access to them, ask at the meetups or in Slack and someone will help you out.

- `bioc-cf-reference`: Reference data used in the cuttlefish project (e.g. sequences for comparable organisms).
- `bioc-cf-supplemental`: Stuff that would be in the supplemental section of a paper. Our eventual cuttlefish sequences, etc.
- `bioc-temp`: Temporary data. Contents are deleted automatically after 60 days.
- More can be created if further organization is helpful.

There are different IAM roles you can be in, depending on your needs. 

- `researcher`: If you just need somewhere to store files temporarily that's not your hard drive. This will let you write to `bioc-temp` and read other buckets.
- `curator`: Everything in `researcher`, plus write access to other buckets. 
