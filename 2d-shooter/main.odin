package main

import "core:math"
import rl "vendor:raylib"

SPEED       :: f32(200)
ENEMY_SPEED :: f32(100)
BULLET_SPEED :: f32(300)

Player :: struct {
    pos:      rl.Vector2,
    rotation: f32,
}

Enemy :: struct {
    pos: rl.Vector2,
}

Bullet :: struct {
	pos: rl.Vector2,
	vel: rl.Vector2,
}

update_player_rotation :: proc(player: ^Player) {
    mouse_pos := rl.GetMousePosition()

    delta_x := mouse_pos.x - player.pos.x
    delta_y := mouse_pos.y - player.pos.y

    angle_radians := math.atan2(delta_y, delta_x)

    player.rotation = angle_radians * (180.0 / math.PI)
}

main :: proc() {
    rl.InitWindow(800, 450, "2D Shooter")
    rl.SetTargetFPS(60)

    bullets := make([dynamic]Bullet)
    defer delete(bullets)

    player := Player{
        pos = {50, 50},
    }
    
    enemy := Enemy{
        pos = {200, 200},
    }

    

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()
        
        update_player_rotation(&player)

        for &bullet in bullets {
            bullet.pos.x += bullet.vel.x * dt
            bullet.pos.y += bullet.vel.y * dt
        }

        // Player input
        if rl.IsKeyDown(.RIGHT) do player.pos.x += SPEED * dt
        if rl.IsKeyDown(.LEFT)  do player.pos.x -= SPEED * dt
        if rl.IsKeyDown(.DOWN)  do player.pos.y += SPEED * dt
        if rl.IsKeyDown(.UP)    do player.pos.y -= SPEED * dt
        if rl.IsMouseButtonPressed(.LEFT) {
            bullet_rotation := player.rotation * (math.PI / 180.0)
            new_bullet := Bullet {
                pos = {player.pos.x, player.pos.y},
                vel = {math.cos(bullet_rotation) * BULLET_SPEED, math.sin(bullet_rotation) * BULLET_SPEED},
            }
            append(&bullets, new_bullet)
        }

        // Enemy movement
        if enemy.pos.x < player.pos.x do enemy.pos.x += ENEMY_SPEED * dt
        if enemy.pos.x > player.pos.x do enemy.pos.x -= ENEMY_SPEED * dt
        if enemy.pos.y < player.pos.y do enemy.pos.y += ENEMY_SPEED * dt
        if enemy.pos.y > player.pos.y do enemy.pos.y -= ENEMY_SPEED * dt

        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawFPS(10, 10)

        cube_size: f32 = 20.0

        // Define the destination rectangle on screen
        rec := rl.Rectangle{
            x      = player.pos.x,
            y      = player.pos.y,
            width  = cube_size,
            height = cube_size,
        }

        // Set origin to the center of the rectangle so it spins in place
        origin := rl.Vector2{ cube_size / 2, cube_size / 2 }

        // Draw the player
        rl.DrawRectanglePro(rec, origin, player.rotation, rl.BLUE)
        
        // Draw the enemy
        rl.DrawRectangle(i32(enemy.pos.x), i32(enemy.pos.y), 20, 20, rl.RED)

        for &bullet in bullets {
            rl.DrawCircle(i32(bullet.pos.x), i32(bullet.pos.y), 5, rl.BLACK)
        }

        rl.EndDrawing()
    }

    rl.CloseWindow()
}