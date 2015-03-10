package ca.utoronto.ece1779.amazon;

import com.amazonaws.AmazonClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.*;

import java.io.File;
import java.io.InputStream;
import java.util.UUID;

public class ImageUploader {
    public static final String BUCKET = "ece1779-group26";
    private static final ProfileCredentialsProvider legit = new ProfileCredentialsProvider();

    private static final AWSCredentials accountID = legit.getCredentials();

    private static final String AWSAccessKey = accountID.getAWSAccessKeyId();
    private static final String AWSSecretKey = accountID.getAWSSecretKey();

    private static final BasicAWSCredentials awsCreds = new BasicAWSCredentials(AWSAccessKey, AWSSecretKey);
    // Oregon region
    private static final Region usWest = Region.getRegion(Regions.US_WEST_2);

    /**
     * Save an image into S3 bucket.
     *
     * @param image path of the image file
     * @return the key where the image was saved on S3
     */
    public static String uploadImage(String image) {
        AmazonS3 s3Client = new AmazonS3Client(awsCreds);
        s3Client.setRegion(usWest);
        File imageFile = new File(image);
        if (!imageFile.exists()) {
            throw new RuntimeException("Image " + image + " does not exist");
        }
        String uuid = UUID.randomUUID().toString();

        try {
            if (s3Client.doesBucketExist(BUCKET)) {
                s3Client.putObject(new PutObjectRequest(BUCKET, uuid, imageFile).withCannedAcl(CannedAccessControlList.PublicRead));
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
        AmazonS3 s3Client = new AmazonS3Client(awsCreds);
        s3Client.setRegion(usWest);
        return s3Client.getObject(BUCKET, uuid).getObjectContent();
    }

    public synchronized static void deleteAllFromBucket() {
        AmazonS3 s3Client = new AmazonS3Client(awsCreds);
        s3Client.setRegion(usWest);
        s3Client.deleteBucket(BUCKET);
        s3Client.createBucket(BUCKET);
    }
}
