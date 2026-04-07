-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 07, 2026 at 08:27 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doctor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `case_id` varchar(30) NOT NULL,
  `patient_id` varchar(30) NOT NULL,
  `clinic_id` varchar(30) NOT NULL,
  `doctor_id` varchar(30) NOT NULL,
  `status` enum('draft','in_progress','completed') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `entry_mode` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`case_id`, `patient_id`, `clinic_id`, `doctor_id`, `status`, `created_at`, `updated_at`, `entry_mode`) VALUES
('CASE1774860407055', 'PTB60A0002', 'C-BAL-3458-B60A', 'DRB60A984238', 'draft', '2026-03-30 08:46:47', '2026-03-31 08:54:08', 'manual'),
('CASE1774860531582', 'PTB60A0004', 'C-BAL-3458-B60A', 'DRB60A984238', 'completed', '2026-03-30 08:48:51', '2026-03-31 02:58:28', 'manual'),
('CASE1774861001631', 'PTB60A0003', 'C-BAL-3458-B60A', 'DRB60A984238', 'draft', '2026-03-30 08:56:41', '2026-03-31 09:17:25', 'manual'),
('CASE1774863445736', 'PTB60A0005', 'C-BAL-3458-B60A', 'DRB60A984238', 'draft', '2026-03-30 09:37:25', '2026-03-31 08:49:35', 'speech'),
('CASE1774947312503', 'PTB60A0004', 'C-BAL-3458-B60A', 'DRB60A984238', 'draft', '2026-03-31 08:55:12', '2026-03-31 08:57:11', 'manual'),
('CASE1775011164098', 'PTB60A0006', 'C-BAL-3458-B60A', 'DRB60A683622', 'completed', '2026-04-01 02:39:24', '2026-04-01 02:43:38', 'manual'),
('CASE1775011466959', 'PTB60A0006', 'C-BAL-3458-B60A', 'DRB60A683622', 'completed', '2026-04-01 02:44:26', '2026-04-01 09:02:33', 'speech'),
('CASE1775097830489', 'PTB60A0009', 'C-BAL-3458-B60A', 'DRB60A683622', 'in_progress', '2026-04-02 02:43:50', '2026-04-06 07:31:43', 'manual');

-- --------------------------------------------------------

--
-- Table structure for table `case_forms`
--

CREATE TABLE `case_forms` (
  `case_id` varchar(30) NOT NULL,
  `chief_complaint` text DEFAULT NULL,
  `presenting_illness` text DEFAULT NULL,
  `past_medical_history` text DEFAULT NULL,
  `medication` text DEFAULT NULL,
  `diet` varchar(20) DEFAULT NULL,
  `smoking` varchar(10) DEFAULT NULL,
  `pan_chewing` varchar(10) DEFAULT NULL,
  `gutkha` varchar(10) DEFAULT NULL,
  `thumb_chewing` varchar(10) DEFAULT NULL,
  `tongue_thrusting` varchar(10) DEFAULT NULL,
  `nail_biting` varchar(10) DEFAULT NULL,
  `lip_biting` varchar(10) DEFAULT NULL,
  `mouth_breathing` varchar(10) DEFAULT NULL,
  `treatment_suggestions` text DEFAULT NULL,
  `treatment_notes` text DEFAULT NULL,
  `surgical_contraindications` text DEFAULT NULL,
  `teeth_indicated_for_extraction` text DEFAULT NULL,
  `impacted_teeth_war` text DEFAULT NULL,
  `need_for_orthognathic_surgery` text DEFAULT NULL,
  `type_of_orthognathic_corrections` text DEFAULT NULL,
  `growth_or_swelling_present` text DEFAULT NULL,
  `page3_treatment_suggestions` text DEFAULT NULL,
  `page3_notes` text DEFAULT NULL,
  `missing_teeth` text DEFAULT NULL,
  `edentulousness` text DEFAULT NULL,
  `acp_pdi_classification` text DEFAULT NULL,
  `abutment_adjunct_therapy` text DEFAULT NULL,
  `abutment_inadequate_tooth_structure` text DEFAULT NULL,
  `occlusal_evaluation` text DEFAULT NULL,
  `class_iv_variant` text DEFAULT NULL,
  `sieberts_classification` text DEFAULT NULL,
  `full_mouth_rehab_required` text DEFAULT NULL,
  `head_shape` text DEFAULT NULL,
  `face_shape` text DEFAULT NULL,
  `arch_shape` text DEFAULT NULL,
  `palatal_vault` text DEFAULT NULL,
  `dental_malocclusion` text DEFAULT NULL,
  `skeletal_malocclusion` text DEFAULT NULL,
  `chin_prominence` text DEFAULT NULL,
  `nasolabial_angle` text DEFAULT NULL,
  `lip_examination` text DEFAULT NULL,
  `maxilla_features` text DEFAULT NULL,
  `mandible_features` text DEFAULT NULL,
  `interarch_relation` text DEFAULT NULL,
  `individual_tooth_variations` text DEFAULT NULL,
  `perio_notes` text DEFAULT NULL,
  `facial_form` text DEFAULT NULL,
  `profile_form` text DEFAULT NULL,
  `salivary_gland` text DEFAULT NULL,
  `tm_joint` text DEFAULT NULL,
  `cervical_lymph_nodes` text DEFAULT NULL,
  `others` text DEFAULT NULL,
  `lip` text DEFAULT NULL,
  `gingiva` text DEFAULT NULL,
  `alveolar_mucosa` text DEFAULT NULL,
  `labial_buccal_mucosa` text DEFAULT NULL,
  `tongue` text DEFAULT NULL,
  `floor_of_mouth` text DEFAULT NULL,
  `palate` text DEFAULT NULL,
  `oro_pharynx` text DEFAULT NULL,
  `labial_frenum_upper` varchar(20) DEFAULT NULL,
  `labial_frenum_lower` varchar(20) DEFAULT NULL,
  `buccal_frenum_upper_left` varchar(20) DEFAULT NULL,
  `buccal_frenum_upper_right` varchar(20) DEFAULT NULL,
  `buccal_frenum_lower_left` varchar(20) DEFAULT NULL,
  `buccal_frenum_lower_right` varchar(20) DEFAULT NULL,
  `lingual_frenum` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dental_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dental_status`)),
  `perio_chart` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`perio_chart`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_forms`
--

INSERT INTO `case_forms` (`case_id`, `chief_complaint`, `presenting_illness`, `past_medical_history`, `medication`, `diet`, `smoking`, `pan_chewing`, `gutkha`, `thumb_chewing`, `tongue_thrusting`, `nail_biting`, `lip_biting`, `mouth_breathing`, `treatment_suggestions`, `treatment_notes`, `surgical_contraindications`, `teeth_indicated_for_extraction`, `impacted_teeth_war`, `need_for_orthognathic_surgery`, `type_of_orthognathic_corrections`, `growth_or_swelling_present`, `page3_treatment_suggestions`, `page3_notes`, `missing_teeth`, `edentulousness`, `acp_pdi_classification`, `abutment_adjunct_therapy`, `abutment_inadequate_tooth_structure`, `occlusal_evaluation`, `class_iv_variant`, `sieberts_classification`, `full_mouth_rehab_required`, `head_shape`, `face_shape`, `arch_shape`, `palatal_vault`, `dental_malocclusion`, `skeletal_malocclusion`, `chin_prominence`, `nasolabial_angle`, `lip_examination`, `maxilla_features`, `mandible_features`, `interarch_relation`, `individual_tooth_variations`, `perio_notes`, `facial_form`, `profile_form`, `salivary_gland`, `tm_joint`, `cervical_lymph_nodes`, `others`, `lip`, `gingiva`, `alveolar_mucosa`, `labial_buccal_mucosa`, `tongue`, `floor_of_mouth`, `palate`, `oro_pharynx`, `labial_frenum_upper`, `labial_frenum_lower`, `buccal_frenum_upper_left`, `buccal_frenum_upper_right`, `buccal_frenum_lower_left`, `buccal_frenum_lower_right`, `lingual_frenum`, `created_at`, `updated_at`, `dental_status`, `perio_chart`) VALUES
('CASE1774860407055', 'Long back pain from last five days', NULL, 'Diabetes and chest cancer', NULL, 'Non Veg', 'No', 'Yes', 'No', 'No', 'No', 'Yes', 'No', 'No', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-03-30 08:47:01', '2026-03-31 08:54:08', NULL, NULL),
('CASE1774860531582', 'Tooth pain in lower region near right	jaw', 'From 5 days', 'Diabetes, Lung cancer', 'BP tablets', 'Veg', 'No', 'No', 'No', 'No', 'Yes', 'No', 'No', 'No', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Landscape', 'U shape', 'Longed', 'Wear', 'Wefwg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-03-30 09:37:54', '2026-03-31 02:58:28', NULL, NULL),
('CASE1774861001631', 'Neck pain', NULL, NULL, NULL, 'Veg', 'No', 'Yes', 'No', 'No', 'Yes', 'No', 'No', 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-03-30 09:21:00', '2026-03-31 08:53:50', NULL, NULL),
('CASE1774863445736', 'severe pain in the lower right back to region', 'pain while chewing', 'diabetes, hypertension, asthma', 'met Foreman amine, inhaler', 'Non Veg', 'Yes', 'No', 'No', 'No', 'No', 'Yes', 'Yes', 'Yes', 'root canal treatment, crown placement, scaling and oral hygiene instructions', 'poor oral hygiene and habit sensation', 'uncontrolled diabetes', NULL, NULL, NULL, NULL, 'mild swelling', 'surgical evaluation and extraction planning', 'patient informed about surgical risk', '16, 36', NULL, 'class three', NULL, NULL, NULL, NULL, 'class two', 'yes', NULL, 'oval', 'high arch', 'high vault', 'an angle class two division one', 'class two Skell pattern', 'reduced Maisa lab angle', 'acute lip examination is in competent lips', NULL, NULL, 'retrographic mandible interact relation', 'increased over jet and deep over by individual tooth variations or rotation of 12 and 22', 'rotation of 12 and 22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-03-31 08:49:35', '2026-03-31 08:49:35', NULL, NULL),
('CASE1774947312503', 'Lower region wisdom teeth', NULL, NULL, NULL, 'Veg', 'No', 'Yes', 'No', 'No', 'No', 'No', 'No', 'No', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-03-31 08:55:40', '2026-03-31 08:57:11', NULL, NULL),
('CASE1775011164098', 'Tooth pain near lower jaw', 'From past five days', 'Diabetes, Lung cancer', 'Inhaler, Paracetemol', 'Non Veg', 'No', 'Yes', 'No', 'No', 'Yes', 'No', 'No', 'Yes', 'Suggested to go for implantation for tooth number 24', NULL, 'Required', '35', '23,34', 'Required', 'Orthodontic', 'Yes', NULL, NULL, '27', NULL, 'Class 3', 'Required', 'Required', NULL, NULL, NULL, NULL, 'Oval', 'Round', 'U shaped', 'Mesophilic', 'Required', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-04-01 02:39:43', '2026-04-06 07:30:36', NULL, NULL),
('CASE1775011466959', 'Severe tooth pain in the lower right back tooth region', 'Pain for five days, increases while chewing, sometimes spontaneous, mild swelling present in the same region', 'Diabetes, hypertension, asthma', 'Metformin, Lapine, salbutamol inhaler', 'Non Veg', 'Yes', 'Yes', 'Yes', 'No', 'No', 'Yes', 'Yes', 'Yes', 'Root canal treatment for 46, Crown placement, scaling and oral hygiene instructions', 'Poor oral hygiene and habit cessation advice given', 'Uncontrolled diabetes', '26 and 38', 'Impacted 38 angular', 'Yes', 'Mandibular setback', 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-04-01 08:19:35', '2026-04-06 07:33:53', NULL, NULL),
('CASE1775097830489', NULL, NULL, NULL, NULL, 'Veg', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Normal Class I', NULL, 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', 'Class I', NULL, '2026-04-02 02:44:04', '2026-04-06 07:31:43', '{\"41\":\"extraction\",\"16\":\"extraction\"}', '{}');

-- --------------------------------------------------------

--
-- Table structure for table `clinics`
--

CREATE TABLE `clinics` (
  `clinic_id` varchar(30) NOT NULL,
  `clinic_name` varchar(150) NOT NULL,
  `clinic_phone` varchar(20) NOT NULL,
  `clinic_email` varchar(190) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clinics`
--

INSERT INTO `clinics` (`clinic_id`, `clinic_name`, `clinic_phone`, `clinic_email`, `address`, `city`, `state`, `pincode`, `password_hash`, `is_active`, `created_at`) VALUES
('C-BAL-3458-B60A', 'Balu clinic', '8919293458', 'konerubalajireddy2468@gmail.com', 'Ananthapur ring road', 'Ananthapur', 'AP', '502190', '$bcrypt-sha256$v=2,t=2b,r=12$fG7j.5j0Ous2mg55jBJ38u$rnnnOUdG4Nb/Oz8g6xCL0dON37Dw1ty', 1, '2026-03-05 03:51:47'),
('C-SIM-3991-95E6', 'SIMDET Clinic', '8991003991', 'simdet1289@saveetha.com', 'Saveetha Nagar', 'Chennai', 'Tamil Nadu', '600123', '$bcrypt-sha256$v=2,t=2b,r=12$PNN6lQB2PcHWq4U/XNsFMe$zXXBgRBwEGUeFgH.VOmB3tXbbzo36se', 1, '2026-04-01 02:31:47'),
('C-SIM-9932-BB84', 'SIMATS Dental Care', '9392849932', 'balajireddybb135@gmail.com', 'Saveetha nagar', 'Chennai', 'Tamil Nadu', '600123', '$bcrypt-sha256$v=2,t=2b,r=12$swIBwedRt7.kcRrWqVUC6O$Q6.X1JcJ6cfHDSAmPg9o2mtGCE35nz2', 1, '2026-03-31 09:29:44'),
('C-SIM-9952-AAD4', 'SIMATS Clinic', '9392849952', 'konerubalaji0595.sse@saveetha.com', 'Saveetha nagar', 'Chennai', 'Tamil Nadu', '600123', '$bcrypt-sha256$v=2,t=2b,r=12$74gwzaLyvM5fzALDDGfOeu$.vmYNJbaPquQ7N.ZU5wynyKLYAinhKC', 1, '2026-03-09 07:51:22');

-- --------------------------------------------------------

--
-- Table structure for table `clinic_login_otps`
--

CREATE TABLE `clinic_login_otps` (
  `id` bigint(20) NOT NULL,
  `clinic_id` varchar(64) NOT NULL,
  `otp_hash` varchar(128) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `used` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clinic_login_otps`
--

INSERT INTO `clinic_login_otps` (`id`, `clinic_id`, `otp_hash`, `expires_at`, `created_at`, `used`) VALUES
(67, 'C-BAL-3458-B60A', 'e65bf768e0cf1dcbb8ba61515e0df0caf4792cf9a33ca4d253c5bfd6402fb5c6', '2026-04-02 02:44:22', '2026-04-02 02:39:22', 1),
(68, 'C-BAL-3458-B60A', '1ca38ba65de75bf9ad59a8cf6442f6f0bd0ab978d20a911a02ee0e2331d46390', '2026-04-02 02:45:09', '2026-04-02 02:40:09', 1),
(69, 'C-BAL-3458-B60A', 'a8e572899d9d4f803ca04ebada6e6180ef4a9ed292c726ddabf6edb43fb17075', '2026-04-06 07:42:28', '2026-04-06 07:37:28', 1);

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `clinic_id` varchar(30) NOT NULL,
  `doctor_id` varchar(50) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `doctor_name` varchar(150) NOT NULL,
  `doctor_email` varchar(150) NOT NULL,
  `doctor_phone` varchar(10) DEFAULT NULL,
  `specialization` varchar(120) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`clinic_id`, `doctor_id`, `password_hash`, `doctor_name`, `doctor_email`, `doctor_phone`, `specialization`, `created_at`, `updated_at`) VALUES
('C-SIM-9952-AAD4', 'DRAAD4042847', '$bcrypt-sha256$v=2,t=2b,r=12$DQfu4d6ktejSEoePChDjF.$bbje9J9u4VuVIGkIzYwJ4ZTV6Rsb/cO', 'Dr. Madavi', 'bommapalli@gmail.com', '9010089939', 'Nurse', '2026-03-09 07:54:07', '2026-03-09 07:54:07'),
('C-BAL-3458-B60A', 'DRB60A010844', '$bcrypt-sha256$v=2,t=2b,r=12$8CcoXV1hsc2K9.Awwc2d5e$BBx71dwhiwMHkqcK8nWwn3dhuxyE14m', 'Dr. Manish', 'manishdhumapalli67@gmail.com', '9012399014', 'Prosthodontics', '2026-04-01 02:34:05', '2026-04-01 02:34:05'),
('C-BAL-3458-B60A', 'DRB60A097719', '$bcrypt-sha256$v=2,t=2b,r=12$M3sow33.4pHA7areXLPBZO$2W7LpGkt7DDFQI8h/2w3IKMeishKMJe', 'Dr Rohith Sharma', 'rohithhitman@gmail.com', '9023345689', 'Implantology', '2026-04-02 02:41:59', '2026-04-02 02:41:59'),
('C-BAL-3458-B60A', 'DRB60A236452', '$bcrypt-sha256$v=2,t=2b,r=12$jKyBVZRF4vKs.PWw7TFYgu$aTg6nhOC7BF1G5WF0V0QoDdYw4FDqpW', 'Dr. Saheb Punia', 'sahebpunia02@gmail.com', '9012345670', 'Periodontics', '2026-03-23 03:27:32', '2026-03-23 03:27:32'),
('C-BAL-3458-B60A', 'DRB60A683622', '$bcrypt-sha256$v=2,t=2b,r=12$k7fjtwM0Khxgl.2gWq2H.u$CtbFw5GwVqyYqZgwgG6SKUDyJmEn.72', 'Dr balu', 'balajireddybb135@gmail.com', '8919293458', 'Prosthodontics', '2026-03-05 04:07:02', '2026-04-01 02:37:51'),
('C-BAL-3458-B60A', 'DRB60A949827', '$bcrypt-sha256$v=2,t=2b,r=12$KFru4JV9RDh9q7u20tGaTe$Nd9jVXJe/C2ugiHvK3hJBEkPXTy79oe', 'Dr Rahul Singh', 'konerubalaji0595.sse@saveetha.com', '8093378871', 'Prosthodontics', '2026-03-31 09:37:07', '2026-03-31 09:37:07'),
('C-BAL-3458-B60A', 'DRB60A988966', '$bcrypt-sha256$v=2,t=2b,r=12$szDRR9cHqdAc/8/EHaV.Le$26w6tbhlo915Sol25DowjUTsYKrYzxm', 'Dr. Raghu Amaran', 'raghuamaran289@gmail.com', '9010089930', 'Prosthodontics', '2026-03-20 06:42:46', '2026-03-20 06:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_password_otps`
--

CREATE TABLE `doctor_password_otps` (
  `id` int(11) NOT NULL,
  `doctor_id` varchar(50) NOT NULL,
  `otp_hash` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_password_otps`
--

INSERT INTO `doctor_password_otps` (`id`, `doctor_id`, `otp_hash`, `expires_at`, `used`, `created_at`) VALUES
(1, 'DRB60A696167', '7b996361ae85c1bb46d1e4c57ee8c8ba8e0a3ecd33f8a313c36fc8cd517066c5', '2026-03-05 07:43:09', 1, '2026-03-05 07:38:09'),
(2, 'DRB60A696167', '1f98075071ae193ed278bb1c41e14000b943b0b9032264fdceeb29ecf1da3498', '2026-03-05 07:43:37', 1, '2026-03-05 07:38:38'),
(3, 'DRB60A696167', '2e37b432deacc299b34eea3376f29eaec7e02cb7aebbb463231298e81f354d64', '2026-03-05 07:43:40', 1, '2026-03-05 07:38:40'),
(4, 'DRB60A696167', '348b41f59fa81956ce57319682e153bc081808380cf932cce162420fe7ae7eb7', '2026-03-05 07:43:58', 1, '2026-03-05 07:38:58'),
(5, 'DRB60A696167', 'd475501a686084f4f020ab77e80bccf40da8b68a35f363958a9b0eec2342fa48', '2026-03-05 07:58:42', 1, '2026-03-05 07:53:42'),
(6, 'DRB60A696167', 'e81bda4c4e8153dfa75521bdffddbbc030d185f5b1713cecf094a3bf3285857e', '2026-03-05 08:04:42', 1, '2026-03-05 07:59:42'),
(7, 'DRB60A696167', '455827a4cdf40e450f2b63caf31a35191fccc1b923c0026eb8da0a1b82f4c6d3', '2026-03-05 08:10:10', 1, '2026-03-05 08:05:10'),
(8, 'DRB60A696167', '078406aabbe453f6d4637ed01d946ab16e08d7cbfa8943c81b480e1efecae9f7', '2026-03-05 08:10:39', 1, '2026-03-05 08:05:39'),
(9, 'DRB60A696167', '7e8b83e95646813cf724b0df5959226d6830f2b6d5914fce54cf2244a58a3bf2', '2026-03-05 08:12:14', 1, '2026-03-05 08:07:14'),
(10, 'DRB60A696167', 'a53286613fe84d1165728dcbe11020891541cf71d545b2afa05b1ea54d503171', '2026-03-09 07:48:36', 1, '2026-03-09 07:43:36'),
(11, 'DRB60A696167', '6606a27a88ff70b396cdbbd4880f039ce94e7644da09e9bc3196d1880a09fc35', '2026-03-09 07:49:39', 1, '2026-03-09 07:44:39'),
(12, 'DRB60A696167', '4383f2618dc14cd4d86f586e2eeee203912c7ff84b158644b268c236f5583b22', '2026-03-09 07:50:08', 1, '2026-03-09 07:45:08'),
(13, 'DRAAD4042847', '14410f081cb334c774276c98951fd4a5563f674c607cc3ed0645070e56f51e64', '2026-03-09 08:01:19', 0, '2026-03-09 07:56:19'),
(14, 'DRB60A683622', '752c5a8108872cd186cc5a7f7ca1e215a50a0f9528aece6587af1442d4b033b0', '2026-03-18 08:33:01', 1, '2026-03-18 08:28:01'),
(15, 'DRB60A984238', 'ec222364d47bd910715edbcf160cc4f018a6b24b929a848c3f86bf692a4695aa', '2026-03-23 03:03:34', 1, '2026-03-23 02:58:34'),
(16, 'DRB60A984238', '78e391c44084036c1436a1dbf09a922ab73866a2f7d888fd80030ceb1adebc2a', '2026-03-23 03:04:38', 1, '2026-03-23 02:59:38'),
(17, 'DRB60A683622', 'b4d3104a52ddb0e460585f45800a420c9cdf3fe7e4b18f2281e9aa0f9a89aedd', '2026-04-01 02:42:02', 1, '2026-04-01 02:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` varchar(20) NOT NULL,
  `clinic_id` varchar(20) NOT NULL,
  `patient_name` varchar(120) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `clinic_id`, `patient_name`, `phone_number`, `city`, `state`, `created_at`) VALUES
(' PTB60A0004', 'C-BAL-3458-B60A', 'Rahul Dhumapalli', '9932422990', 'Tirupati', 'Andhra Pradesh', '2026-03-23 03:21:48'),
('PTB60A0002', 'C-BAL-3458-B60A', 'Gokul Domala', '6301703639', 'Banglore', 'Karnataka', '2026-03-16 07:34:53'),
('PTB60A0003', 'C-BAL-3458-B60A', 'Stalin Clerk', '9010089930', 'Ooty', 'TamilNadu', '2026-03-23 03:20:00'),
('PTB60A0005', 'C-BAL-3458-B60A', 'Ranveer Singh', '8899002233', 'Amritsar', 'Punjab', '2026-03-23 03:24:03'),
('PTB60A0006', 'C-BAL-3458-B60A', 'Sundar Pichai', '9922999929', 'Chennai', 'Tamil Nadu', '2026-03-23 03:25:13'),
('PTB60A0007', 'C-BAL-3458-B60A', 'Komma Naveen', '9010089933', 'Puna', NULL, '2026-03-31 09:39:01'),
('PTB60A0008', 'C-BAL-3458-B60A', 'Murali Mohan', '9278913420', 'Tirupati', 'Andhra Pradesh', '2026-04-01 02:34:57'),
('PTB60A0009', 'C-BAL-3458-B60A', 'Virat Kohli', '8999200014', 'Banglore', 'Karnataka', '2026-04-02 02:42:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `case_forms`
--
ALTER TABLE `case_forms`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `clinics`
--
ALTER TABLE `clinics`
  ADD PRIMARY KEY (`clinic_id`),
  ADD UNIQUE KEY `uniq_clinic_email` (`clinic_email`),
  ADD UNIQUE KEY `uniq_clinic_phone` (`clinic_phone`);

--
-- Indexes for table `clinic_login_otps`
--
ALTER TABLE `clinic_login_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clinic_id` (`clinic_id`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `doctor_email` (`doctor_email`),
  ADD UNIQUE KEY `doctor_phone` (`doctor_phone`),
  ADD KEY `fk_doctors_clinic` (`clinic_id`);

--
-- Indexes for table `doctor_password_otps`
--
ALTER TABLE `doctor_password_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doctor_id` (`doctor_id`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD KEY `clinic_id` (`clinic_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clinic_login_otps`
--
ALTER TABLE `clinic_login_otps`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `doctor_password_otps`
--
ALTER TABLE `doctor_password_otps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `case_forms`
--
ALTER TABLE `case_forms`
  ADD CONSTRAINT `fk_case_forms_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `fk_doctors_clinic` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`clinic_id`) ON DELETE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`clinic_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
