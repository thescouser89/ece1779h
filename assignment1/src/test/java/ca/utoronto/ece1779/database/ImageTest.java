package ca.utoronto.ece1779.database;

import ca.utoronto.ece1779.database.Image;
import ca.utoronto.ece1779.database.User;
import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Random;
import java.util.UUID;

@Ignore
public class ImageTest {

    @Test
    public void createAndDeleteImage() {
        String username = generateRandomString();
        User user = new User(username, "imagetest");
        User.addUser(user);
        User userRetrieved = User.findUser(username);

        String originalImage = generateRandomString();
        Image image = new Image(userRetrieved.getId(), originalImage,
                generateRandomString(),
                generateRandomString(),
                generateRandomString());
        Image.addImage(image);

        List<Image> retrieved = Image.findImagesWithUserId(userRetrieved.getId());

        Image found = null;
        for (Image img : retrieved) {
            System.out.println(img.getOriginalImage());

            if (img.getOriginalImage().equals(originalImage)) {
                found = img;
                break;
            }
        }

        assertNotNull(found);

        Image.deleteImage(found);
        User.deleteUser(user);
    }

    private static String generateRandomString() {
        String uuid = UUID.randomUUID().toString();
        return uuid.substring(0, 15);
    }
}
