const std = @import("std");
const builtin = @import("builtin");

const data = @import("data.zig");

// Colors for output
const RED = "\x1b[31;1m";
const GREEN = "\x1b[32;1m";
const CYAN = "\x1b[36;1m";
const WHITE = "\x1b[37;1m";
const DIM = "\x1b[2m";
const BOLD = "\x1b[1m";
const RESET = "\x1b[0m";
const NEWLINE = if (builtin.os.tag == .windows) "\r\n" else "\n";

pub fn main() !void {
    // get the standard output for writing
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // pick a random number, max size the length of the builtins
    const rand = std.crypto.random;
    const d = rand.intRangeAtMost(u8, 0, data.builtins.len);

    // pick a random builtin
    const function = data.builtins[d];

    // print out the documentation
    try std.fmt.format(stdout, "{s}{s}{s}{s}{s}{s}", .{
        BOLD,
        function.signature,
        BOLD ++ RESET,
        NEWLINE ++ NEWLINE,
        function.documentation,
        NEWLINE,
    });

    // always flush when you are done
    try bw.flush();
}
