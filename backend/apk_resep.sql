-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 03, 2025 at 04:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apk_sayuran`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('a75f3f172bfb296f2e10cbfc6dfc1883', 'i:2;', 1738593348),
('a75f3f172bfb296f2e10cbfc6dfc1883:timer', 'i:1738593348;', 1738593348),
('e9b6cc1432541b9ceebf113eee05eeba', 'i:3;', 1738593311),
('e9b6cc1432541b9ceebf113eee05eeba:timer', 'i:1738593311;', 1738593311),
('f1f70ec40aaa556905d4a030501c0ba4', 'i:1;', 1738595093),
('f1f70ec40aaa556905d4a030501c0ba4:timer', 'i:1738595093;', 1738595093);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_01_31_022204_create_posts_table', 2),
(4, '2025_01_31_033454_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'aa5c2071d6c63116a44ec0c0dadd5658fa9bdb96440d07412b6ab2954d7995b4', '[\"*\"]', NULL, NULL, '2025-02-01 10:38:57', '2025-02-01 10:38:57'),
(2, 'App\\Models\\User', 1, 'auth_token', '44b6dcdc1110538db3669f7281327e394c6084bc43159f4e1e5be6d55e5ca442', '[\"*\"]', NULL, NULL, '2025-02-01 10:39:04', '2025-02-01 10:39:04'),
(3, 'App\\Models\\User', 1, 'auth_token', '62d59cfa22d6ea1e52d832f08ad4c4ca9962269323d8c46d84ead0bc5686e7e2', '[\"*\"]', '2025-02-02 14:24:09', NULL, '2025-02-02 10:50:09', '2025-02-02 14:24:09'),
(4, 'App\\Models\\User', 1, 'auth_token', 'a8b354543f3d0b15e9bd785e9a28a71e51bd1499439d02bc40cfe05e8c7d42bd', '[\"*\"]', '2025-02-02 14:39:23', NULL, '2025-02-02 14:39:04', '2025-02-02 14:39:23'),
(5, 'App\\Models\\User', 1, 'auth_token', '88596d4702c24e652e5c6b1d23050330bfa5628af7f94eef63d6c85fdd55cbd6', '[\"*\"]', NULL, NULL, '2025-02-02 14:40:44', '2025-02-02 14:40:44'),
(6, 'App\\Models\\User', 1, 'auth_token', 'ff87dcf6976d68c5bd1340c1871406809ddc0419184c9be2e0ba4102ce9d5b1c', '[\"*\"]', NULL, NULL, '2025-02-02 23:00:35', '2025-02-02 23:00:35'),
(7, 'App\\Models\\User', 1, 'auth_token', '91e3820bcee473e71fcc5a4ef10238e0b6f9f00154e3fdbafae80b080ba4a0db', '[\"*\"]', '2025-02-03 01:09:22', NULL, '2025-02-02 23:26:17', '2025-02-03 01:09:22'),
(8, 'App\\Models\\User', 1, 'auth_token', '1f86fd5fc5c7820565ecf94aa48322e2bfe255a3a0ce294be5e6d98977b6ef1b', '[\"*\"]', '2025-02-03 01:12:37', NULL, '2025-02-03 01:12:35', '2025-02-03 01:12:37'),
(9, 'App\\Models\\User', 1, 'auth_token', '8f176e9212b99adbdd26c59dfdc929d7b8a223c4d76355f88c5b75b9286a0ad9', '[\"*\"]', '2025-02-03 01:13:17', NULL, '2025-02-03 01:13:16', '2025-02-03 01:13:17'),
(10, 'App\\Models\\User', 2, 'auth_token', 'f664b54390e670cb573d72271e9c7b54b0ac740f54b59a18f6e3b7e15bbf6135', '[\"*\"]', '2025-02-03 01:14:36', NULL, '2025-02-03 01:14:34', '2025-02-03 01:14:36'),
(11, 'App\\Models\\User', 1, 'auth_token', '29c5a54b0330605b1332daca374861c08cb9a2ca779d307d235a6eb5f34ce3d9', '[\"*\"]', '2025-02-03 01:29:17', NULL, '2025-02-03 01:14:55', '2025-02-03 01:29:17'),
(12, 'App\\Models\\User', 1, 'auth_token', 'f06b1b364c441f25f62f5417a8edd64c8c104c19affe745c8398a4a00dfa80a2', '[\"*\"]', '2025-02-03 01:49:36', NULL, '2025-02-03 01:30:18', '2025-02-03 01:49:36'),
(13, 'App\\Models\\User', 1, 'auth_token', 'd20bbf804b39a50d249892f4e15e3b952e7a45c9700a368843d267e66830f753', '[\"*\"]', '2025-02-03 07:17:33', NULL, '2025-02-03 01:53:10', '2025-02-03 07:17:33'),
(14, 'App\\Models\\User', 2, 'auth_token', '4ba5b36b7fa634a0e4714398109930be2e198c7faba51f7d13766a418488e4db', '[\"*\"]', '2025-02-03 07:34:17', NULL, '2025-02-03 07:17:48', '2025-02-03 07:34:17'),
(15, 'App\\Models\\User', 1, 'auth_token', '046d9b2084ff1517a68d0ec06a286b07677a0536dd427e4a02c4a5f8ac49ffa8', '[\"*\"]', '2025-02-03 08:03:53', NULL, '2025-02-03 07:34:48', '2025-02-03 08:03:53');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `description`, `image`, `created_at`, `updated_at`) VALUES
(9, 1, 'resep Rendang', 'ini dibuat dengan cinta', '/storage/resep_images/xqgdqg78nF8LpqibV7xof9YCUDjvk8zpdHO2qNle.png', '2025-02-03 02:08:38', '2025-02-03 02:08:38'),
(14, 1, 'Resep Minuman Jeruk Segar', 'Hello Word', '/storage/resep_images/IGwW8qwDUhfaExp476IdkuVEuIDjsA3pDM5KwYev.png', '2025-02-03 07:43:53', '2025-02-03 07:43:53'),
(15, 1, 'Resep Coklat Manis', 'Hello Word', '/storage/resep_images/Sl4a23q7kjis5gHEZCBSpMjCLsh0zvsIqiP6DIMy.png', '2025-02-03 07:49:51', '2025-02-03 07:49:51'),
(16, 1, 'Resep Dessert', 'Hello Word', '/storage/resep_images/VSeQdVFP7kjPaECl1s3h5Vkj4EI3gGbUkWnROYBk.png', '2025-02-03 07:50:29', '2025-02-03 07:50:29');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('C0GQMMo2ZOMEHMDj9nDOMDXURdpWIFZ7QQK0Di9W', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjNKMnFKU2JYRnBWMERFUTY1UGRGR3NXWEgzT3JjaVNHZ0dXcjMzNiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyMToiaHR0cDovLzEyNy4wLjAuMTo4MDAwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738429383),
('K4QB2aCbxEeP23sQecisxE47evt76ru8ik8ksmVV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2xrMWdZVUdZU2o1QzFZZWo4U01hblJic2tEdGZmWmhEajhEc1FTcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738429728),
('XJe7Jj4wx6nciDopKHhfX6ozvTYa97OMvtYYIYwX', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3FOY0xBUlh4TEQ1bVJkRzZWUzVlUEI1TGpFTmxkcDJtT0I4ZTNwRCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyMDoiaHR0cDovLzEwLjAuMi4yOjgwMDAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1738428481);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'user', 'user@gmail.com', NULL, '$2y$12$pJGNAeyTE0ImtwxMy6Xw9eRQx7V3tuAKjB2yiVKLvXO/W4dICgfbi', NULL, '2025-02-01 10:22:22', '2025-02-01 10:22:22'),
(2, 'test', 'test@gmail.com', NULL, '$2y$12$4fqnVQl4X7zhqwZ0U5DuVOt1C8A2j0F71LlPkULnnlPqpGByIfkBO', NULL, '2025-02-03 01:14:20', '2025-02-03 01:14:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
