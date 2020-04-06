## Gists generator 

[![CircleCI](https://circleci.com/gh/sirech/generate-gists-for-post.svg?style=svg)](https://circleci.com/gh/sirech/generate-gists-for-post) [![Depfu](https://badges.depfu.com/badges/d464da264935e160624c2f07fde057d4/overview.svg)](https://depfu.com/github/sirech/generate-gists-for-post)

This is intended to parse [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) documents and extract all the code blocks and post them as [gists](https://gist.github.com/).

It is intended to be used to prepare a markdown document for publication in [Medium](https://medium.com/).

### Requirements

* ruby (>= 2.6.3)

### How to use it

```shell
thor gists:create name_of_the_post
```

An API Token with permissions to create _gists_ is required, expected to be exported under the `GIST_GITHUB_API_TOKEN` environment variable.
