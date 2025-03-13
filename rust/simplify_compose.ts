// execute with https://bun.sh
// This adjusts the compose file to work in more generic environments
// - explicitly expose ports
// - no network defintion / ip
// - no logging config

import { parse, stringify } from 'yaml'



const c = await Bun.file('./compose.yaml').text().then(parse)

c.services.rust.ports = [
    '28015:28015/udp',
    '28016:28016/udp',
    '28016:28016/tcp',
    '28082:28082/tcp'
]

delete c.services.rust.logging
delete c.services.rust.networks
delete c.networks

console.log(stringify(c))

