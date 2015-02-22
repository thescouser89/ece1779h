package ca.utoronto.ece1779.images;

import ca.utoronto.ece1779.amazon.ImageUploader;
import ca.utoronto.ece1779.database.Image;

import java.util.UUID;

public class ImageHelper {
    private final int userId;
    private final String originalImage;
    private String firstTransformationImage;
    private String secondTransformationImage;
    private String thirdTransformationImage;

    public ImageHelper(int userId, String originalImage) {
        this.userId = userId;
        this.originalImage = originalImage;

        firstTransformationImage = getRandomUUID();
        secondTransformationImage = getRandomUUID();
        thirdTransformationImage = getRandomUUID();

        ImageManipulation.gothamFilter(originalImage, firstTransformationImage);
        ImageManipulation.borderFilter(originalImage, secondTransformationImage);
        ImageManipulation.hipsterFilter(originalImage, thirdTransformationImage);
    }

    public Image uploadImagesToS3AndSaveToDatabase() {
        String oriKey = ImageUploader.uploadImage(originalImage);
        String frtKey = ImageUploader.uploadImage(firstTransformationImage);
        String scdKey = ImageUploader.uploadImage(secondTransformationImage);
        String thdKey = ImageUploader.uploadImage(thirdTransformationImage);

        Image image = new Image(userId, oriKey, frtKey, scdKey, thdKey);
        Image.addImage(image);
        return image;
    }

    private String getRandomUUID() {
        return originalImage + "-" + UUID.randomUUID().toString();
    }
}
