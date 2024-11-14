using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace Sokoban;

public class Game1 : Game
{

    // TEXTURES
    Texture2D wallTexture, crateTexture, floorTexture, grassTexture, endGoalTexture;
    private GraphicsDeviceManager _graphics;
    private SpriteBatch _spriteBatch;

    public Game1()
    {
        _graphics = new GraphicsDeviceManager(this);
        Content.RootDirectory = "Content";
        IsMouseVisible = true;
    }

    protected override void Initialize()
    {
        // TODO: Add your initialization logic here

        base.Initialize();
    }

    protected override void LoadContent()
    {
        _spriteBatch = new SpriteBatch(GraphicsDevice);

        wallTexture = Content.Load<Texture2D>("PNG/Default size/Blocks/block_05");
        crateTexture = Content.Load<Texture2D>("PNG/Default size/Crates/crate_07");
        floorTexture = Content.Load<Texture2D>("PNG/Default size/Ground/ground_06");
        grassTexture = Content.Load<Texture2D>("PNG/Default size/Ground/ground_05");
        endGoalTexture = Content.Load<Texture2D>("PNG/Default size/Ground/ground_03");
        
    }

    protected override void Update(GameTime gameTime)
    {
        if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed || Keyboard.GetState().IsKeyDown(Keys.Escape))
            Exit();

        // TODO: Add your update logic here

        base.Update(gameTime);
    }

    protected override void Draw(GameTime gameTime)
    {
        GraphicsDevice.Clear(Color.CornflowerBlue);

        _spriteBatch.Begin();
        _spriteBatch.Draw(wallTexture, new Vector2(0,0), Color.White);
        _spriteBatch.End();
        base.Draw(gameTime);
    }
}
