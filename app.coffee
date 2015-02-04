HOME = if process.platform is 'win32' then process.env.USERPROFILE else process.env.HOME

nobone = require 'nobone'
process.env.NODE_ENV = 'development'

{ kit, service, renderer} = nobone null, checkUpgrade: false
kit.require 'colors'

config = kit._.defaults require './config',
    startDir: HOME
    port: '8998'

config.startDir is '$HOME' and config.startDir = HOME

tpl = kit._.template kit.fs.readFileSync 'editor.tpl'
editor = '' + kit.fs.readFileSync 'kitchen-sink.html'
usage = kit._.template kit.fs.readFileSync 'usage.tpl'

replaceTpl = do ->
    toWrite = (kit.fs.readFileSync('./noboneDir.tpl') + '').replace('__PWD__', config.startDir)
    kit.fs.writeFileSync kit.path.join(__dirname, 'node_modules/nobone/assets/dir/index.tpl'), toWrite

nameMap =
    js: 'javascript'
    md: 'markdown'
    tpl: 'html'

service.use '/src-noconflict', renderer.static 'src-min-noconflict'
service.use '/src', renderer.static 'src-min'
service.use '/demo', renderer.static 'demo'
service.use '/pre', renderer.staticEx config.startDir, './ass'


bodyParser = require('body-parser');
multer = require('multer');


service.use(bodyParser.json());
service.use(bodyParser.urlencoded({ extended: true }));
service.use(multer());

service.get '/', (req, res)->
    kit.log req.path
    path = req.query.read
    if not path
        return res.send usage host: req.headers.host, rootDir: kit.path.resolve config.startDir

    kit.readFile path
    .then (data)->
        language = kit.path.extname(path)[1...]
        if not language
            language = 'sh'
        else
            language = nameMap[language.toLowerCase()] or language
        res.send tpl
            code: kit._.escape data + ''
            language: language
            path: path
    .catch (e)->
        kit.err e
        res.send "File Not Found!"


service.post '/save', (req, res)->
    {data, file} = req.body
    if not file then return res.send 'false'
    kit.writeFile file, data
    .then ()->
        res.send "true"
    .catch (e)->
        kit.err e
        res.send 'fasle'

service.get '/editor', (req, res)->
    res.send editor

service.get '*', renderer.staticEx config.startDir, './ass'


service.listen config.port
kit.log ('Service start on port: ' + config.port).cyan

