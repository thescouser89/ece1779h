package ca.utoronto.ece1779.images;

import org.junit.Test;

public class ImageManipulationTest {
    @Test
    public void transform() {
        ClassLoader classLoader = getClass().getClassLoader();
        String loc = classLoader.getResource("SanFrancisco_0.jpg").getPath();
        ImageManipulation.hipsterFilter(loc, "SanFranT1.jpg");
        ImageManipulation.gothamFilter(loc, "SanFranT2.jpg");
        ImageManipulation.borderFilter(loc, "SanFranT3.jpg");
    }
}
