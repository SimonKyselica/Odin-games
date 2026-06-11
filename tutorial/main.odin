package game

import rl "vendor:raylib"

SPEED :: f32(200)

rectanglePos : struct {
	x: f32,
	y: f32,
}

main :: proc() {

	rectanglePos.x = 50
	rectanglePos.y = 50

    rl.InitWindow(800, 450, "raylib [core] example - basic window")
		

    for !rl.WindowShouldClose() {

		dt := rl.GetFrameTime()

		if rl.IsKeyDown(.RIGHT) {
			rectanglePos.x += SPEED * dt
		}
		if rl.IsKeyDown(.LEFT) {
			rectanglePos.x -= SPEED * dt
		}
		if rl.IsKeyDown(.DOWN) {
			rectanglePos.y += SPEED * dt
		}
		if rl.IsKeyDown(.UP) {
			rectanglePos.y -= SPEED * dt
		}

        rl.BeginDrawing()
            rl.ClearBackground(rl.RAYWHITE)
			rl.DrawFPS(10, 10)
            rl.DrawRectangle(i32(rectanglePos.x), i32(rectanglePos.y), 20, 20, rl.RED)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}