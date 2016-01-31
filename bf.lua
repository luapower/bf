--brainfuck jit compiler ui (Cosmin Apreutesei, public domain).

if ... == 'bf' then return end --prevent loading as module

io.stdout:setvbuf'no'
io.stderr:setvbuf'no'

require'dynasm' --plug in the dasl loader
local bf = require('bf_'..require'ffi'.arch) --load the bf compiler for this arch

local function readfile(filename) --read a file's contents to a string
	local file = assert(io.open(filename, 'rb'), 'file not found')
	local s = file:read'*a'
	file:close()
	return s
end

local filename = ...
local code

if not filename then
	io.stderr:write('Yet another brainfuck JIT compiler.\n')
	io.stderr:write('Usage: luajit ', arg[0], ' INFILE.b (`-` for stdin) \n')
	io.stderr:write('Look in `media/b` folder for sample programs.\n\n')
	io.stderr:write('While you\'re doing that, take this nice mandelbrot set.\n\n')
	code = readfile'media/b/mandelbrot.b'
elseif filename == '-' then
	code = io.stdin:read'*a'
else
	code = readfile(filename)
end

bf(code)
