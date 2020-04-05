## Gists generator 

This is intended to parse [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) documents and extract all the code blocks and post them as [gists](https://gist.github.com/).

It is intended to be used to prepare a markdown document for publication in [Medium](https://medium.com/).

### Requirements

* ruby (>= 2.6.3)

### How to use it

```shell
thor gists:create name_of_the_post
```

An API Token with permissions to create _gists_ is required, expected to be exported under the `GIST_GITHUB_API_TOKEN` environment variable.
