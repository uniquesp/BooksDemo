--
-- database: books
--

--
-- Table user
--

   CREATE TABLE `tblusers` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `FullName` varchar(120) DEFAULT NULL,
  `EmailId` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `ContactNo` char(11) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Intrest` varchar(255) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table Book
--

CREATE TABLE `tblbooks` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `publication_year` int(4) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `price` decimal(10, 2) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL, -- URL/path to the book image
  `status` BOOLEAN DEFAULT true, 
  `RegDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

