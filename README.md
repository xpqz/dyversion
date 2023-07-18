# dyversion

A git tag is a 'bookmark' to a commit SHA. It can be anything. We're using a tagging strategy of

    major.minor-YYYY-MM-DD

A release is a tag. We inject the tag name into a function called `Version`, residing in `main.aplf` before we create, and upload the asset to a GitHub release.

To make a new release using this approach, you need:

1. GitHub token available as an environment variable called `GITHUB_TOKEN`. 
1. The [jq](https://jqlang.github.io/jq/) utility (a streaming json processor) installed.

