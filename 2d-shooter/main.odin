package game

import rl "vendor:raylib"

SPEED :: f32(200)
ENEMY_SPEED :: f32(100)

playerPos : struct {
	x: f32,
	y: f32,
}

enemyPos : struct {
	x: f32,
	y: f32,
}

main :: proc() {

	playerPos.x = 50
	playerPos.y = 50

	enemyPos.x = 200
	enemyPos.y = 200

    rl.InitWindow(800, 450, "2D Shooter")
		

    for !rl.WindowShouldClose() {

		dt := rl.GetFrameTime()

		//Player input
		if rl.IsKeyDown(.RIGHT) {
			playerPos.x += SPEED * dt
		}
		if rl.IsKeyDown(.LEFT) {
			playerPos.x -= SPEED * dt
		}
		if rl.IsKeyDown(.DOWN) {
			playerPos.y += SPEED * dt
		}
		if rl.IsKeyDown(.UP) {
			playerPos.y -= SPEED * dt
		}

		//Enemy movement
		if enemyPos.x < playerPos.x {
			enemyPos.x += ENEMY_SPEED * dt
		}
		if enemyPos.x > playerPos.x {
			enemyPos.x -= ENEMY_SPEED * dt
		}
		if enemyPos.y < playerPos.y {
			enemyPos.y += ENEMY_SPEED * dt
		}
		if enemyPos.y > playerPos.y {
			enemyPos.y -= ENEMY_SPEED * dt
		}

        rl.BeginDrawing()
            rl.ClearBackground(rl.RAYWHITE)
			rl.DrawFPS(10, 10)
            rl.DrawRectangle(i32(playerPos.x), i32(playerPos.y), 20, 20, rl.BLUE)
			rl.DrawRectangle(i32(enemyPos.x), i32(enemyPos.y), 20, 20, rl.RED)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}