Technical Design Documentation: MongoDB Atlas Cloud Backup Configuration

1. Introduction:
This technical design document outlines the configuration of MongoDB Atlas Cloud Backup using Terraform. The infrastructure code provisions a backup schedule and snapshot for a MongoDB cluster in the MongoDB Atlas cloud environment.

2. Prerequisites:
To successfully implement this configuration, ensure the following:
- Access to a MongoDB Atlas account.
- Terraform installed on the local machine.
- Proper authentication and permissions for interacting with the MongoDB Atlas API.

3. Terraform Resources:
This design utilizes two Terraform resources:
- `mongodbatlas_cloud_backup_schedule`: Configures the backup schedule for the MongoDB cluster.
- `mongodbatlas_cloud_backup_snapshot`: Configures a backup snapshot for the MongoDB cluster.

4. `mongodbatlas_cloud_backup_schedule` Resource:
- `count`: Determines if the backup schedule should be created based on the `var.mongodb_enabled` variable. If `mongodb_enabled` is true, one backup schedule will be created; otherwise, it will not be created.
- `project_id`: Specifies the ID of the MongoDB Atlas project to which the cluster belongs. It references the `mongodbatlas_cluster.cluster` resource.
- `cluster_name`: Specifies the name of the MongoDB cluster. It references the `mongodbatlas_cluster.cluster` resource.
- `reference_hour_of_day` and `reference_minute_of_hour`: Sets the time at which the backup schedule triggers. In this case, the backup will occur at 3:45 AM.
- `restore_window_days`: Defines the number of days within which the backups are eligible for restoration.

The following policy items are added to the `mongodbatlas_cloud_backup_schedule` resource:
- `policy_item_daily`: Sets up a daily backup with a retention period of 2 days.
- `frequency_interval`: Indicates the backup frequency in days.
- `retention_unit`: Specifies the unit of retention (in this case, "days").
- `retention_value`: Sets the number of days for which the backups are retained.

- `policy_item_weekly`: Configures a weekly backup on Thursdays with a retention period of 3 weeks.
- `frequency_interval`: Indicates the backup frequency on a particular day of the week (4 represents Thursday).
- `retention_unit`: Specifies the unit of retention (in this case, "weeks").
- `retention_value`: Sets the number of weeks for which the backups are retained.

- `depends_on`: Specifies that the creation of the backup schedule depends on the completion of the `mongodbatlas_cluster.cluster` resource.

5. `mongodbatlas_cloud_backup_snapshot` Resource:
- `project_id`: Specifies the ID of the MongoDB Atlas project to which the cluster belongs. It references the `mongodbatlas_cluster.cluster` resource.
- `cluster_name`: Specifies the name of the MongoDB cluster. It references the `mongodbatlas_cluster.cluster` resource.
- `description`: Provides an optional description for the backup snapshot. It references the `var.description` variable.
- `retention_in_days`: Sets the number of days for which the backup snapshot will be retained. It references the `var.retention_in_days` variable.

6. Workflow:
When executed, Terraform will create the specified backup schedule and snapshot for the MongoDB cluster in MongoDB Atlas. The backup schedule will include daily and weekly backups with their respective retention periods. The snapshot will have a defined retention period as well.






Technical Design Documentation: Google Cloud KMS Configuration for MongoDB Atlas Encryption at Rest

1. Introduction:
This technical design document outlines the configuration of Google Cloud Key Management Service (KMS) for MongoDB Atlas Encryption at Rest using Terraform. The infrastructure code provisions a service account, creates a key ring and crypto key in Google Cloud KMS, and configures MongoDB Atlas to use the encryption at rest feature with Google Cloud KMS.

2. Prerequisites:
To successfully implement this configuration, ensure the following:
- Access to a Google Cloud Platform (GCP) project.
- Terraform installed on the local machine.
- Proper authentication and permissions for interacting with the Google Cloud Platform API.

3. Terraform Resources:
This design utilizes several Terraform resources:
- `google_service_account`: Creates a service account for encryption at rest in MongoDB Atlas.
- `google_project_iam_member`: Assigns IAM roles to the service account.
- `google_service_account_key`: Creates a key for the service account.
- `google_kms_key_ring`: Creates a key ring in Google Cloud KMS.
- `google_kms_crypto_key`: Creates a crypto key within the key ring.
- `mongodbatlas_encryption_at_rest`: Configures MongoDB Atlas to use encryption at rest with Google Cloud KMS.

4. Service Account for KMS:
- `google_service_account`: Creates a service account with a name generated using the MongoDB cluster's name and a prefix. The account ID is limited to 25 characters.
- `display_name`: Sets a display name for the service account.

5. Assigning IAM Roles:
- `google_project_iam_member`: Assigns three IAM roles to the service account:
  - `roles/cloudkms.admin`: Provides administrative access to Google Cloud KMS.
  - `roles/cloudkms.cryptoKeyEncrypterDecrypter`: Allows the service account to encrypt and decrypt crypto keys in Google Cloud KMS.
  - `roles/owner`: Grants full ownership access to the GCP project.

6. Creating Service Account Key:
- `google_service_account_key`: Creates a service account key for the previously created service account.
- `public_key_type`: Specifies the type of the public key file.

7. Creating Key Ring and Crypto Key:
- `google_kms_key_ring`: Creates a key ring in Google Cloud KMS. The name is generated using a random hexadecimal ID.
- `name`: Specifies the name of the key ring.
- `location`: Sets the location of the key ring to "global".

- `google_kms_crypto_key`: Creates a crypto key within the key ring.
- `name`: Specifies the name of the crypto key, using a random hexadecimal ID.
- `key_ring`: References the ID of the key ring created above.

8. Atlas Encryption at Rest Configuration:
- `mongodbatlas_encryption_at_rest`: Configures MongoDB Atlas to use encryption at rest with Google Cloud KMS.
- `project_id`: Specifies the ID of the MongoDB Atlas project.
- `google_cloud_kms_config`:
  - `enabled`: Enables encryption at rest with Google Cloud KMS.
  - `service_account_key`: Decodes and provides the private key of the service account.
  - `key_version_resource_id`: Specifies the resource ID of the crypto key and sets the version to 1.

9. Random ID Generation:
- `random_id`: Generates random IDs for the names of the key ring and crypto key.
- `keepers`: Uses the current timestamp as the keeper to regenerate the random ID when the timestamp changes.
- `byte_length`: Sets the length of the random byte sequence generated by the resource.


10. Workflow:
When executed, Terraform will create a service account, assign IAM roles, create a key ring and crypto key in Google Cloud KMS, and configure MongoDB Atlas to use encryption at rest with Google Cloud KMS.


Encryption at rest is a security measure that ensures data stored in a database or file system is encrypted, providing an additional layer of protection against unauthorized access. In this case, the encryption at rest is implemented using Google Cloud Key Management Service (KMS) and integrated with the Atlas project.

Key Management Service (KMS): Google Cloud KMS is a managed service that allows you to generate, use, and manage cryptographic keys securely. It provides a central repository for managing encryption keys and performs cryptographic operations, such as encryption and decryption, using these keys.

Service Account: A service account is created specifically for managing encryption at rest in the Atlas project. A service account is an identity that represents a non-human entity (in this case, the encryption process) and is used to authenticate and authorize actions performed on behalf of the service. The service account is granted the necessary permissions and roles in Google Cloud IAM to interact with KMS and perform encryption and decryption operations.

Keyring and Crypto Key: A keyring is created within Google Cloud KMS to act as a logical container for cryptographic keys. The keyring is associated with the Atlas project. Within the keyring, a cryptographic key is generated, which is used for encrypting and decrypting the data at rest. This key is securely managed by KMS and protected by the service account's permissions.

Integration with Atlas: The Atlas project is configured to enable encryption at rest using the Google Cloud KMS integration. The Atlas service integrates with KMS by providing the necessary configuration parameters.

Enabled: This setting indicates that encryption at rest is enabled for the Atlas project.
Service Account Key: The private key of the service account created earlier is provided to Atlas. This key is used to authenticate the service account when interacting with KMS and performing encryption and decryption operations.
Key Version Resource ID: This identifies the specific version of the cryptographic key to be used for encryption and decryption. In this case, the first version of the key created in the keyring is selected.
When data is stored in Atlas, it goes through the encryption process before being written to disk. The data is encrypted using the cryptographic key managed by Google Cloud KMS. This process converts the plain text data into an unreadable, encrypted form using industry-standard encryption algorithms. The encrypted data is then stored in the underlying storage system.

When data needs to be accessed or retrieved from Atlas, the decryption process takes place. The encrypted data is retrieved from storage and passed to Google Cloud KMS along with the appropriate key and version. KMS performs the decryption operation using the corresponding key and returns the decrypted data to Atlas, which can then provide the data in its original, readable format to the authorized user or application.

By integrating with Google Cloud KMS, Atlas ensures that data at rest is protected with strong encryption and that the encryption keys are securely managed by Google's infrastructure. This helps safeguard sensitive data from unauthorized access, even in the event of physical storage compromise or unauthorized access to the underlying infrastructure.
