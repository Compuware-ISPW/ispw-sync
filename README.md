# ISPW Sync GitHub docker action

This action will load changed components into ISPW server. It uses [BMC/Compuware ISPW CLI container](https://hub.docker.com/r/bmctopaz/ispwcli) to push changed components to ISPW. In order to use [ispw-sync@v](http://github/compuware-ispw/ispw-sync) action, the GitHub VM launched in the workflow must enable the following:
* support Docker - nested VM (For example, self-hosted Linux runner or ubuntu-latest)
* Access ISPW host and port from the VM

## Inputs

### `host`

**Required** The ISPW server host. For example, `"cw09"`

### `port`

**Required** The ISPW server port. For example, `47623`

### `encryptionProtocol`

**Optional** the encryption protocol for the connection (None, Auto, SSLv3, TLS, TLSv1, TLSv1.1, TLSv1.2). Default `"None"`

### `codePage`

**Optional** the code page for the connection. default, `1047`

### `timeout`

**Optional** the timeout (in minutes) for the connection. Default, `0`

### `uid`

**Required** the user name for the connection. For example, `"foo"`

### `pass`

**Required** the password for the connection. Please use secrets, such as, `${{ secrets.ISPWPASS }}`

### `runtimeConfiguration`

**Required** the ISPW server config. For example, `"TPZP"`

### `stream`

**Required** the ISPW server stream. For example, `"PLAY"`

### `application`

**Required** the ISPW server application. For example, `"PLAY"`

### `checkoutLevel`

**Required** the ISPW server level. For example, `"DEV1"`

### `gitUid`

**Required** the user name for the GIT repository. For example, `"gitfoo"`

### `gitPass`

**Required** the password for the GIT repository. Please use secrets, such as, `${{ secrets.GITPASS }}`

### `containerCreation`

**Optional** The option to indicate how often to create a new ISPW container (per-commit, per-branch). Default, `"per-commit"`

### `containerDescription`

**Optional** The custom description to be used for the ISPW container.

## Outputs

### `automaticBuildJson`

The automatic build parameters JSON

### `changedProgramsJson`

The changed programs JSON

## Example usage

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
        uses: actions/ispw-sync@v1
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
