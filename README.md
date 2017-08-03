# probe-mongo
The mongo probe connects to mongo component instances and lists their databases.  This probe can be used to verify a deployed service provides access to the mongo API on the component's service network (the same network which is used to consume that service).

The mongo probe supports the following actions:

* `service_up` (default) - connect to mongo and list databases, retrying until success or the action times out.  Succeed if the mongo service is up (connect and database list operations succeed).
* `check_access` - connect to mongo and list databases, retrying until success or the action times out.  If a database is provided, fail if that database does not exist.  If a user is also provided, authenticate to that database or fail.  Otherwise, succeed if the connect and database list operations succeed.  This action can be used to verify access to a user/password protected mongo service.

These actions support the following arguments:

* `port` - port number (default `27017`)
* `timeout` - operation timeout *per service instance*, in seconds (default `120`).  This is how long to keep retrying if the mongo service does not respond.

The `check_access` action supports the following additional arguments:

* `user` - user (default `None`)
* `password` - password (default `None`)
* `database` - database (default `None`)

## examples

Here are a few examples in the form of quality gates specified in a Skopos TED file (target environment descriptor).  Quality gates associate probe executions to one or more component images.  During application deployment Skopos executes the specified probes to assess components deployed with matching images.

```yaml
quality_gates:
    mongo_test:
        images:
            - mongo:*
        steps:

            # verify mongo service is up (default action service_up)
            - probe: opsani/probe-mongo:v1

            # verify mongo access
            - probe:
                image: opsani/probe-mongo:v1
                action: check_access
                label: "check mongo access on alternate port with timeout"
                arguments: { port: 10000, timeout: 30 }
            - probe:
                image: opsani/probe-mongo:v1
                action: check_access
                label: "check mongo access with user/password/database"
                arguments:
                    user: "my_user"
                    password: "my_password"
                    database: "my_database"
```
