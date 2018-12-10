Blackfire Cookbook
===========================

This cookbook installs and configures the blackfire stack.

Requirements
------------

#### Platform
* Ubuntu (12.04/13.04/14.04/16.06/18.04)
* Debian (7/8/9)
* RedHat Based (CentOS 6.4 and Fedora 20 tested, others should work)

Attributes
----------

The following attributes are available to affect the installation/configuration of the Backfire stack

#### blackfire::default

* `node['blackfire']['agent']['version']` - Sets which version of the agent to install. Default last version.
* `node['blackfire']['agent']['server_id']` - Sets the Server ID to use for the agent (See https://blackfire.io/account/agents)
* `node['blackfire']['agent']['server_token']` - Sets the Server Token to use for the agent (See https://blackfire.io/account/agents)
* `node['blackfire']['agent']['log_level']` - Sets the logging level for the agent. Default 1
* `node['blackfire']['agent']['log_file']` - Sets where the agent write logs. Default "stderr"
* `node['blackfire']['agent']['socket']` - Sets where the socket the agent will listen to. Default "unix:///var/run/blackfire/agent.sock"

Usage
-----
#### blackfire::default
Add agent Server ID and token and include `blackfire` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[blackfire]"
  ],
  "blackfire": {
    "agent": {
      "server_id": "my-agent-server-id",
      "server_token": "my-agent-server-token"
    }
  }
}
```

#### blackfire::agent

Used if you wish to install only the agent.

#### blackfire::php

Used if you wish to install only the PHP extension.

### Note about blackfire::php

This cookbook makes no assumption about the webserver you use.

Therefore this is *your* responsability to write a wrapper and notify your
webserver (ie. Apache or php5-fpm) for reload/restart or subscribe the good
resources.
To do that, you can use `blackfire_php` resource to manage blackfire.ini and notify php service according to php version. It's very usefull if you have many php version on the same server.

You can obtain futher informations on wrapper cookbooks here:
https://blog.chef.io/2017/02/14/writing-wrapper-cookbooks/

Resources
---------

### 'blackfire_php'

Manage blackfire.ini for a specific version of PHP

#### Actions

- `create` - (default) Create blackfire.ini file 

#### Properties

Name           | Types  | Description                                                                                                                        | Default         
-------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------- | ----------------
`version`      | String | Define version of PHP                                                                                                              | <resource_name> 
`cookbook`     | String | Cookbook name of blackfire.ini template                                                                                            | 'blackfire'     
`ini_path`     | String | Path of blackfire.ini. Autodetected if not specified                                                                               | ''  
`agent_timeout | String | Sets the PHP extension timeout when communicating with the agent                                                                   | '0.25'
`log_file`     | String | Sets where the PHP extension write logs                                                                                            |
`log_level`    | String | Sets the logging level for the PHP extension                                                                                       |
`socket`       | String | Sets where the socket the agent will listen to                                                                                     | 'unix:///var/run/blackfire/agent.sock'
`server_id`    | String | Sets the Server ID to use for probe fine-grained configuration (See https://blackfire.io/doc/configuration#probe-configuration)    |
`server_token` | String | Sets the Server Token to use for probe fine-grained configuration (See https://blackfire.io/doc/configuration#probe-configuration) |

#### Examples

In a wrapper cookbook:
```ruby
include_recipe 'blackfire'

blackfire_php '7.1' do
  agent_timeout '0.75'
  log_file '/var/log/php/7.1/blackfire.log'
  server_id 'foo'
  server_token 'bar'
end
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Tests
-----

Three test suites exist:

- two using kitchen.ci (meant to be run localy by contributors)
- one using rspec (meant to be run by travis, not localy).

These test suites can be launched by using `rake integration:vagrant` or
`rake integration:docker` for the kitchen.ci one and `rake travis` for rspec.

Supermarket share
-----------------

You need [stove](http://sethvargo.github.io/stove/) to publish the cookbook on
supermarket. Once it's done use `rake publish`

License and Authors
-------------------
- Author:: Tugdual Saunier (<tugdual.saunier@blackfire.io>)

```text
Copyright:: 2014-2016 Blackfire.io

See LICENSE file
```
