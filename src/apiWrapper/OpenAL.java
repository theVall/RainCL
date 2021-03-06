/**
 * 
 */
package apiWrapper;

import java.io.IOException;

import org.lwjgl.openal.AL;
import org.newdawn.slick.openal.Audio;
import org.newdawn.slick.openal.AudioLoader;
import org.newdawn.slick.openal.SoundStore;
import org.newdawn.slick.util.ResourceLoader;

/**
 * @author Valentin Bruder (vbruder@uos.de)
 * @date 12.05.2013
 *
 * Class for audio handling.
 * This class uses the "slick-util" library for sound play back.
 */
public class OpenAL
{
    private static boolean initialized;
    private static Audio background;    
    private static String bgFile = "media/sounds/background.ogg";
    
    /**
     * Play background sound in a loop. Sleeps as long as audio is played and loops then.
     * @see http://www.slick2d.org/wiki/index.php/Slick_util
     */
    public void init()
    {
        if (!initialized)
        {
            try
            {
                background = AudioLoader.getAudio("OGG", ResourceLoader.getResourceAsStream(bgFile));
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
            initialized = true;
            //params: pitch, gain, loop
            background.playAsSoundEffect(1.0f, 0.3f, true);
            SoundStore.get().poll(0);
        }
        else
        {
            background.playAsSoundEffect(1.0f, 0.3f, true);
            SoundStore.get().poll(0);
        }
    }
    
    /**
     * Stop sound play back.
     */
    public void stopSound()
    {
        if (initialized && background.isPlaying())
            background.stop();
    }
    
    /**
     * Clean up audio.
     */
    public void destroy()
    {
        if (initialized && background.isPlaying())
            background.stop();
        AL.destroy();
    }
}
