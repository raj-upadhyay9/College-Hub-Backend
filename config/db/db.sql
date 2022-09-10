CREATE SCHEMA "food";

CREATE SCHEMA "private";

CREATE SCHEMA "laundry";

CREATE SCHEMA "library";

CREATE SCHEMA "salon";

CREATE TYPE "OrderStatus" AS ENUM (
  'pending',
  'ready',
  'completed'
);

CREATE TYPE "Gender" AS ENUM (
  'male',
  'female'
);

CREATE TYPE "Course" AS ENUM (
  'CSE',
  'ECE',
  'EC',
  'ME',
  'BT'
);

CREATE TYPE "School" AS ENUM (
  'Engineering',
  'Business',
  'Law',
  'Media'
);

CREATE TYPE "Degree" AS ENUM (
  'BTech',
  'MTech',
  'BCA',
  'MCA',
  'BALLB',
  'BBALLB',
  'BBA',
  'Media',
  'BA'
);

CREATE TABLE "User" (
  "enrollment_no" varchar PRIMARY KEY,
  "first_name" varchar,
  "second_name" varchar,
  "age" int8,
  "gender" Gender,
  "hostler" boolean,
  "password" varchar,
  "email" varchar
);

CREATE TABLE "Hostle" (
  "enrollment_no" varchar PRIMARY KEY,
  "block" char,
  "floor" int2,
  "room_no" int4,
  "roommate" varchar
);

CREATE TABLE "Education" (
  "enrollment_no" varchar PRIMARY KEY,
  "school" School,
  "degree" Degree,
  "course" Course,
  "year" int8,
  "group_id" int4,
  "subjects" Subject[],
  "batch_id" varchar
);

CREATE TABLE "Subject" (
  "subject_id" varchar PRIMARY KEY,
  "name" varchar,
  "lab" int2,
  "tutorial" int2,
  "lecture" int2,
  "faculties_id" Faclty[]
);

CREATE TABLE "Faculty" (
  "faculty_id" varchar PRIMARY KEY,
  "first_name" varchar,
  "second_name" varchar,
  "age" integer,
  "batchs" Batch[],
  "subjects" Subject[]
);

CREATE TABLE "Batch" (
  "batch_id" varchar PRIMARY KEY,
  "students" User[],
  "count" int8,
  "BR_id" varchar,
  "mentor_id" varchar,
  "group_id" int8
);

CREATE TABLE "Group" (
  "group_id" varchar PRIMARY KEY,
  "cr_id" varchar,
  "student_count" integer
);

CREATE TABLE "cleaning" (
  "room_no" varchar PRIMARY KEY,
  "cleaned" boolean,
  "cleaned_on" datetime
);

CREATE TABLE "car_pooling" (
  "pool_id" varchar PRIMARY KEY,
  "desctiption" varchar,
  "enrollment_no" varchar,
  "departure" datetime,
  "contact_no" int,
  "destination" varchar,
  "max_people" int,
  "curr_people" int,
  "vehicle" varchar,
  "male" int,
  "female" int
);

CREATE TABLE "food"."order" (
  "order_id" varchar PRIMARY KEY,
  "stud_id" varchar,
  "store_id" varchar,
  "item_id" varchar,
  "price" float,
  "cook_time" timestamp,
  "order_status" OrderStatus
);

CREATE TABLE "food"."store" (
  "store_id" varchar PRIMARY KEY,
  "name" varchar,
  "status" varchar,
  "store_image" varchar
);

CREATE TABLE "food"."food_items" (
  "item_id" varchar PRIMARY KEY,
  "store_id" varchar,
  "item_name" varchar,
  "item_price" int,
  "item_image" varchar
);

CREATE TABLE "private"."laundry" (
  "order_id" varchar PRIMARY KEY,
  "bag_id" int,
  "user" varchar,
  "given_on" datetime,
  "taken_on" datetime,
  "status" OrderStatus
);

CREATE TABLE "laundry"."order" (
  "order_id" varchar PRIMARY KEY,
  "item_count" int,
  "kurta" int,
  "pajama" int,
  "shirt" int,
  "t_shirt" int,
  "pant" int,
  "lower" int,
  "shorts" int,
  "bedsheet" int,
  "pillow_cover" int,
  "towel" int,
  "dupatta" int
);

CREATE TABLE "library"."book" (
  "isbn" varchar PRIMARY KEY,
  "book_no" vachar,
  "title" varchar,
  "edition" varchar,
  "category" varchar,
  "price" int
);

CREATE TABLE "library"."reports" (
  "enrollment_no" varchar,
  "reg_no" varchar PRIMARY KEY,
  "book_no" varchar,
  "issue_date" datetime,
  "return_date" datetime
);

CREATE TABLE "salon"."treatments" (
  "treatment_id" varchar PRIMARY KEY,
  "treatment_name" varchar,
  "price" int,
  "gender" Gender
);

CREATE TABLE "salon"."booking" (
  "booking_id" varchar PRIMARY KEY,
  "enrollment_no" varchar,
  "gender" varchar,
  "treatment_id" varchar,
  "availability" varchar,
  "on" datetime,
  "total_price" int,
  "status" OrderStatus
);

ALTER TABLE "cleaning" ADD FOREIGN KEY ("room_no") REFERENCES "Hostle" ("room_no");

ALTER TABLE "car_pooling" ADD FOREIGN KEY ("enrollment_no") REFERENCES "User" ("enrollment_no");

ALTER TABLE "User" ADD FOREIGN KEY ("enrollment_no") REFERENCES "Education" ("enrollment_no");

ALTER TABLE "Hostle" ADD FOREIGN KEY ("enrollment_no") REFERENCES "User" ("enrollment_no");

ALTER TABLE "User" ADD FOREIGN KEY ("enrollment_no") REFERENCES "Hostle" ("roommate");

CREATE TABLE "Subject_Faculty" (
  "Subject_subject_id" varchar NOT NULL,
  "Faculty_subjects" Subject[] NOT NULL,
  PRIMARY KEY ("Subject_subject_id", "Faculty_subjects")
);

ALTER TABLE "Subject_Faculty" ADD FOREIGN KEY ("Subject_subject_id") REFERENCES "Subject" ("subject_id");

ALTER TABLE "Subject_Faculty" ADD FOREIGN KEY ("Faculty_subjects") REFERENCES "Faculty" ("subjects");


CREATE TABLE "Subject_Faculty(1)" (
  "Subject_faculties_id" Faclty[] NOT NULL,
  "Faculty_faculty_id" varchar NOT NULL,
  PRIMARY KEY ("Subject_faculties_id", "Faculty_faculty_id")
);

ALTER TABLE "Subject_Faculty(1)" ADD FOREIGN KEY ("Subject_faculties_id") REFERENCES "Subject" ("faculties_id");

ALTER TABLE "Subject_Faculty(1)" ADD FOREIGN KEY ("Faculty_faculty_id") REFERENCES "Faculty" ("faculty_id");


CREATE TABLE "Education_Subject" (
  "Education_subjects" Subject[] NOT NULL,
  "Subject_subject_id" varchar NOT NULL,
  PRIMARY KEY ("Education_subjects", "Subject_subject_id")
);

ALTER TABLE "Education_Subject" ADD FOREIGN KEY ("Education_subjects") REFERENCES "Education" ("subjects");

ALTER TABLE "Education_Subject" ADD FOREIGN KEY ("Subject_subject_id") REFERENCES "Subject" ("subject_id");


ALTER TABLE "Batch" ADD FOREIGN KEY ("students") REFERENCES "User" ("enrollment_no");

ALTER TABLE "Batch" ADD FOREIGN KEY ("mentor_id") REFERENCES "Faculty" ("faculty_id");

ALTER TABLE "Batch" ADD FOREIGN KEY ("BR_id") REFERENCES "User" ("enrollment_no");

ALTER TABLE "Group" ADD FOREIGN KEY ("group_id") REFERENCES "Education" ("group_id");

ALTER TABLE "Group" ADD FOREIGN KEY ("group_id") REFERENCES "Batch" ("group_id");

ALTER TABLE "Education" ADD FOREIGN KEY ("batch_id") REFERENCES "Batch" ("batch_id");

ALTER TABLE "food"."order" ADD FOREIGN KEY ("stud_id") REFERENCES "User" ("enrollment_no");

ALTER TABLE "food"."order" ADD FOREIGN KEY ("store_id") REFERENCES "food"."store" ("store_id");

ALTER TABLE "food"."order" ADD FOREIGN KEY ("item_id") REFERENCES "food"."food_items" ("item_id");

ALTER TABLE "food"."food_items" ADD FOREIGN KEY ("store_id") REFERENCES "food"."store" ("store_id");

ALTER TABLE "private"."laundry" ADD FOREIGN KEY ("user") REFERENCES "User" ("enrollment_no");

ALTER TABLE "laundry"."order" ADD FOREIGN KEY ("order_id") REFERENCES "private"."laundry" ("order_id");

ALTER TABLE "library"."reports" ADD FOREIGN KEY ("book_no") REFERENCES "library"."book" ("book_no");

ALTER TABLE "library"."reports" ADD FOREIGN KEY ("enrollment_no") REFERENCES "User" ("enrollment_no");

ALTER TABLE "salon"."booking" ADD FOREIGN KEY ("enrollment_no") REFERENCES "User" ("enrollment_no");

ALTER TABLE "salon"."booking" ADD FOREIGN KEY ("gender") REFERENCES "User" ("enrollment_no");

ALTER TABLE "salon"."booking" ADD FOREIGN KEY ("treatment_id") REFERENCES "salon"."treatments" ("treatment_id");
