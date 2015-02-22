package ca.utoronto.ece1779.amazon;

import com.amazonaws.AmazonClientException;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.S3Object;

import java.io.File;
import java.io.InputStream;
import java.util.UUID;

public class ImageUploader {
    private static final String ACCESS_KEY = "figure out yourself :)";
    private static final String SECRET_KEY = "so so secret";
    private static final String BUCKET = "ece1779-group26";

    private static final BasicAWSCredentials awsCreds = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
    private static final AmazonS3 s3Client = new AmazonS3Client(awsCreds);

    // Oregon region
    private static final Region usWest = Region.getRegion(Regions.US_WEST_2);

    static {
        s3Client.setRegion(usWest);
    }

    /**
     * Save an image into S3 bucket.
     *
     * @param image path of the image file
     * @return the key where the image was saved on S3
     */
    public static String uploadImage(String image) {
        File imageFile = new File(image);
        if (!imageFile.exists()) {
            throw new RuntimeException("Image " + image + " does not exist");
        }
        String uuid = UUID.randomUUID().toString();

        try {
            if (s3Client.doesBucketExist(BUCKET)) {
                s3Client.putObject(BUCKET, uuid, imageFile);
                return uuid;
            } else {
                throw new RuntimeException("Bucket " + BUCKET + " does not exist");
            }
        } catch (AmazonClientException ace) {
            ace.printStackTrace();
        }
        return null;
    }

    public static InputStream getImage(String uuid) {
        return s3Client.getObject(BUCKET, uuid).getObjectContent();
    }

}
