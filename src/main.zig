//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
pub fn main() !void {
    try one();
    try two();
}

fn one() !void {
    std.debug.print("Starting one..\n", .{});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    var stdout = bw.writer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const cwd = std.fs.cwd();
    const contents = try cwd.readFileAlloc(alloc, "/home/parallels/Docs/Git/aoc-zig/aoc/2015/001/input.txt", 8192);
    defer alloc.free(contents);

    var floor: i32 = 0;
    for (contents) |char| {
	if (char == '(') {
	    floor += 1;
	} else if (char == ')') {
	    floor -= 1;
	}
    }
    try stdout.print("Santa is on floor {d}\n\n", .{floor});
    try bw.flush();
}

fn two() !void {
    std.debug.print("Starting two..\n", .{});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    var stdout = bw.writer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const cwd = std.fs.cwd();
    const contents = try cwd.readFileAlloc(alloc, "/home/parallels/Docs/Git/aoc-zig/aoc/2015/001/input.txt", 8192);
    defer alloc.free(contents);

    var floor: i32 = 0;
    for (contents, 0..) |char, index| {
	if (floor == -1) {
	    try stdout.print("Santa is on basement floor {d} at position {d}\n", .{floor, index});
	    break;
	}
	if (char == '(') {
	    floor += 1;
	} else if (char == ')') {
	    floor -= 1;
	}
    }
    try bw.flush();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "use other module" {
    try std.testing.expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}

const std = @import("std");

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("aoc_zig_lib");
