# BMC/Compuware ISPW Sync GitHub action

This action will load changed components into ISPW server. It uses [BMC/Compuware ISPW CLI container](https://hub.docker.com/r/bmctopaz/ispwcli) to push changed components to ISPW. In order to use [compuware-ispw/ispw-sync@v20.6.1.gtk](http://github/compuware-ispw/ispw-sync) action, the GitHub VM launched in the workflow must enable the following:
* support Docker - nested VM (For example, self-hosted Linux runner or ubuntu-latest)
* Access ISPW host and port from the VM

## Table of Contents
<!-- toc -->

- [BMC/Compuware ISPW Sync GitHub action](#bmccompuware-ispw-sync-github-action)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Troubleshooting](#troubleshooting)
  - [License summary](#license-summary)
  - [Limitation](#limitation)

<!-- tocstop -->


## Usage

```yaml
  job_sync:
    runs-on: [self-hosted, ubuntu20]
    name: ISPW Sync
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Synchronize
        uses: compuware-ispw/ispw-sync@v20.6.1.gtk
        id: sync
        with:
            host: 'cw09'
            port: 47623
            uid: 'foo'
            pass: ${{ secrets.ISPWPASS }}
            runtimeConfiguration: 'TPZP'
            stream: 'PLAY'
            application: 'PLAY'
            checkoutLevel: 'DEV2'
            gitUid: 'gitfoo'
            gitPass: ${{ secrets.GITPASS }}
            encryptionProtocol: 'None'
            codePage: 1047
            timeout: 0
            showEnv: true
        - name: Output automatic build parameters
            run: echo "automaticBuildJson=${{ steps.sync.outputs.automaticBuildJson }}"
        - name: Output changed programs
            run: echo "changedProgramsJson=${{ steps.sync.outputs.changedProgramsJson }}"
```


## Inputs

| Input name | Required | Description |
| :--------- | :------- | :---------- |
| `host` | **Required** | The ISPW server host. For example, `"cw09"` |
| `port` | **Required** | The ISPW server port. For example, `47623` |
| `encryptionProtocol` | **Optional** | The encryption protocol for the connection (None, Auto, SSLv3, TLS, TLSv1, TLSv1.1, TLSv1.2). Default `"None"`
| `codePage` | **Optional** | The code page for the connection. default, `1047` |
| `timeout` | **Optional** | The timeout (in minutes) for the connection. Default, `0` |
| `uid` | **Required** | The user name for the connection. For example, `"foo"` |
| `pass` | **Required** | The password for the connection. Please use secrets, such as, `${{ secrets.ISPWPASS }}` |
| `runtimeConfiguration` | **Required** | The ISPW server config. For example, `"TPZP"` |
| `stream` | **Required** | The ISPW server stream. For example, `"PLAY"` |
| `application` | **Required** | The ISPW server application. For example, `"PLAY"` |
| `checkoutLevel` | **Required** | The ISPW server level. For example, `"DEV1"` |
| `gitUid` | **Required** | The user name for the GIT repository. For example, `"gitfoo"` |
| `gitPass` | **Required** | The password for the GIT repository. Please use secrets, such as, `${{ secrets.GITPASS }}` |
| `containerCreation` | **Optional** | The option to indicate how often to create a new ISPW container (per-commit, per-branch). Default, `"per-commit"` |
| `containerDescription` | **Optional** | The custom description to be used for the ISPW container. |
| `showEnv` | **Optional** | Show value of environment variables for debugging. Possible values are `true` or `false` |



## Outputs

| Output name | Output type | Description |
| :---------- | :---------- | :---------- |
| `automaticBuildJson` | JSON | The automatic build parameters JSON. For example, `{"containerId":"PLAY004807","releaseId":" ","taskLevel":"DEV2","taskIds":["7E54341E21FF","7E54341E2449","7E54341E2610"]}`|
| `changedProgramsJson` | JSON | The changed programs JSON. For example, `{ version: 1.0.0, programs: [ { version: 1.0.0, programName: TREXX10, programLanguage: CLST, isImpact: false, application: PLAY, stream: PLAY, level: DEV2 }, { version: 1.0.0, programName: TPROG10, programLanguage: COB, isImpact: false, application: PLAY, stream: PLAY, level: DEV2 }, { version: 1.0.0, programName: TPROG11, programLanguage: COB, isImpact: false, application: PLAY, stream: PLAY, level: DEV2 } ] }`|

## Troubleshooting

This action emits debug logs to help troubleshoot failure. To see the debug logs, set the input `showEnv: true`.


## License summary

This code is made available under the MIT license.


## Limitation

This action is only available for Linux [virtual environments](https://help.github.com/en/articles/virtual-environments-for-github-actions#supported-virtual-environments-and-hardware-resources).