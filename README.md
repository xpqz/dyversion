# dyversion

The `release.sh` script in this repository does the following:

1. Reads the non-committed file `current_version.txt`. It contains the "current release" in the shape of `major.minor`, but could be whatever you want.
1. Appends today's date in the shape of `YYYY-MM-DD`. This is the release-id.
1. Replaces the template `{{VERSION}}` in `main.aplf` with this release-id.
1. Lays down a git "tag" to be the release-id.
1. Creates a new GitHub release.
1. Uploads the file `main.aplf` to the release.
1. Replaces the patched `main.aplf` with the backup `sed` created, so that the template remains.

A git tag is a 'bookmark' to a commit SHA. It can be anything. We're using a tagging strategy of

    major.minor-YYYY-MM-DD

A release is a tag. We inject the tag name into a function called `Version`, residing in `main.aplf` before we create, and upload the asset to a GitHub release.

To make a new release using this approach, you need:

1. GitHub token available as an environment variable called `GITHUB_TOKEN`. 
1. The [jq](https://jqlang.github.io/jq/) utility (a streaming json processor) installed.

