const std = @import("std");

const root = @import("root.zig");

pub const MEMORY_SIZE = 4096;
pub const PROGRAM_START = 0x200;
pub const DISPLAY_WIDTH = 64;
pub const DISPLAY_HEIGHT = 32;
pub const font = struct {
    pub const DATA: [80]u8 = .{
        0xF0, 0x90, 0x90, 0x90, 0xF0, 0x20, 0x60, 0x20, 0x20, 0x70, 0xF0, 0x10, 0xF0, 0x80, 0xF0, 0xF0,
        0x10, 0xF0, 0x10, 0xF0, 0x90, 0x90, 0xF0, 0x10, 0x10, 0xF0, 0x80, 0xF0, 0x10, 0xF0, 0xF0, 0x80,
        0xF0, 0x90, 0xF0, 0xF0, 0x10, 0x20, 0x40, 0x40, 0xF0, 0x90, 0xF0, 0x90, 0xF0, 0xF0, 0x90, 0xF0,
        0x10, 0xF0, 0xF0, 0x90, 0xF0, 0x90, 0x90, 0xE0, 0x90, 0xE0, 0x90, 0xE0, 0xF0, 0x80, 0x80, 0x80,
        0xF0, 0xE0, 0x90, 0x90, 0x90, 0xE0, 0xF0, 0x80, 0xF0, 0x80, 0xF0, 0xF0, 0x80, 0xF0, 0x80, 0x80,
    };
    pub const START = 0x50;
    pub const END = START + DATA.len;
};
pub const KEY_COUNT = 16;
pub const CALL_STACK_SIZE = 16;
pub const VARIABLE_REGISTER_COUNT = 16;

pub const Interpreter = struct {
    memory: [MEMORY_SIZE]u8,
    address_register: u16,
    variable_register: [VARIABLE_REGISTER_COUNT]u8,
    call_stack: [CALL_STACK_SIZE]u16,
    call_stack_index: u4,
    delay_timer: u8,
    sound_timer: u8,
    display: [DISPLAY_HEIGHT][DISPLAY_WIDTH]bool,
    keypad: [KEY_COUNT]bool,

    const Self = @This();

    pub const INIT = Self{
        .memory = .{0} ** font.START ++ font.DATA ++ .{0} ** (MEMORY_SIZE - font.END),
        .address_register = 0,
        .variable_register = .{0} ** VARIABLE_REGISTER_COUNT,
        .call_stack = .{0} ** CALL_STACK_SIZE,
        .call_stack_index = 0,
        .delay_timer = 0,
        .sound_timer = 0,
        .display = .{.{false} ** DISPLAY_WIDTH} ** DISPLAY_HEIGHT,
        .keypad = .{false} ** KEY_COUNT,
    };
};

test "constants" {
    _ = MEMORY_SIZE;
    _ = PROGRAM_START;
    _ = DISPLAY_WIDTH;
    _ = DISPLAY_HEIGHT;
    _ = font.DATA;
    _ = font.START;
    _ = font.END;
    _ = KEY_COUNT;
    _ = CALL_STACK_SIZE;
    _ = VARIABLE_REGISTER_COUNT;
    _ = Interpreter.INIT;
}