# Add Signtool Action

> Locates the latest version of Microsoft's signtool installed and adds it to the runner's PATH

[![View License on GitHub](https://badgen.net/github/license/KamaranL/add-signtool-action?cache=3600)](./LICENSE.txt)
[![View Latest Release on GitHub](https://badgen.net/github/release/KamaranL/add-signtool-action/stable?icon=github&label=latest&cache=3600)](https://github.com/KamaranL/add-signtool-action)

- [Add Signtool Action](#add-signtool-action)
  - [Usage](#usage)
    - [Outputs](#outputs)
      - [Examples](#examples)

Use this action to locate `signtool.exe` and add it to the `PATH` environment variable for easier execution throughout the rest of a workflow's job.

\*\***This action will <u>only run on Windows</u> runners, it will fail fast otherwise.**

Refer to [Microsoft's documentation](https://learn.microsoft.com/en-us/dotnet/framework/tools/signtool-exe#examples) for more on signtool and how it works.

## Usage

```yml
on: push
jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4

      - uses: KamaranL/add-signtool-action@v1
        id: signtool

      - run: Write-Output "$env:SIGNTOOL_DIR"
        # prints out the absolute path to the located signtool executable
        shell: pwsh
        env:
          SIGNTOOL_DIR: ${{ steps.signtool.outputs.signtool-x64 }}
```

### Outputs

This action outputs the path of the located signtool into the output key `signtool-${{ runner.arch }}`.

#### Examples

| ${{ runner.arch }} | outputs key  |
| ------------------ | ------------ |
| x64                | signtool-x64 |
| arm                | signtool-arm |
