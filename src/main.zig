const std = @import("std");
const data = @import("data.zig");

pub fn main() !void {
    // get the standard output for writing
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // pick a random number, max size the length of the builtins
    const rand = std.crypto.random;
    const d = rand.intRangeAtMost(u8, 0, data.builtins.len);

    // pick a random builtin
    const builtin = data.builtins[d];

    // print out the documentation
    try stdout.print("{s}\n", .{builtin.name});
    try stdout.print("{s}\n", .{builtin.documentation});

    // always flush when you are done
    try bw.flush();
}
