// // components/profile_image_upload.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:wil_flutter_application/models/employee.dart';
// import 'dart:io';
// import '../viewmodels/employee_viewmodel.dart';

// class ProfileImageUpload extends StatefulWidget {
//   final String userId;
//   final String? currentImageUrl;
//   final double size;

//   const ProfileImageUpload({
//     super.key,
//     required this.userId,
//     this.currentImageUrl,
//     this.size = 120,
//   });

//   @override
//   _ProfileImageUploadState createState() => _ProfileImageUploadState();
// }

// class _ProfileImageUploadState extends State<ProfileImageUpload>
//     with SingleTickerProviderStateMixin {
//   File? _imageFile;
//   bool _isUploading = false; // ADD THIS LINE - Missing variable declaration
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 85,
//       maxWidth: 800,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });

//       // Auto-upload after selection
//       await _uploadImage();
//     }
//   }

//   // Enhanced with better error handling
//   Future<void> _uploadImage() async {
//     if (_imageFile == null) return;

//     final employeeViewModel = Provider.of<EmployeeViewModel>(
//       context,
//       listen: false,
//     );

//     try {
//       // Show loading state
//       setState(() {
//         _isUploading = true;
//       });

//       await employeeViewModel.uploadProfileImage(_imageFile!);

//       // Show success feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 8),
//               Text('Profile image updated successfully!'),
//             ],
//           ),
//           backgroundColor: Color(0xFF48BB78),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       );
//     } catch (e) {
//       // Show error feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               Icon(Icons.error_outline, color: Colors.white),
//               SizedBox(width: 8),
//               Text('Failed to upload image: ${e.toString()}'),
//             ],
//           ),
//           backgroundColor: Color(0xFFE53E3E),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   // ADD THIS MISSING METHOD
//   void _showImagePickerModal() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => _buildImagePickerModal(),
//     );
//   }

//   // ADD THIS MISSING METHOD
//   Widget _buildImagePickerModal() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Drag handle
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Choose Profile Photo',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2D3748),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildImageOption(
//                     icon: Icons.photo_library,
//                     text: 'Gallery',
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickImage();
//                     },
//                   ),
//                   _buildImageOption(
//                     icon: Icons.photo_camera,
//                     text: 'Camera',
//                     onTap: () async {
//                       Navigator.pop(context);
//                       final picker = ImagePicker();
//                       final pickedFile = await picker.pickImage(
//                         source: ImageSource.camera,
//                         imageQuality: 85,
//                         maxWidth: 800,
//                       );
//                       if (pickedFile != null) {
//                         setState(() {
//                           _imageFile = File(pickedFile.path);
//                         });
//                         await _uploadImage();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(color: Color(0xFF718096), fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ADD THIS MISSING METHOD
//   Widget _buildImageOption({
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 70,
//             height: 70,
//             decoration: BoxDecoration(
//               color: Color(0xFF4299E1).withOpacity(0.1),
//               shape: BoxShape.circle,
//               border: Border.all(color: Color(0xFF4299E1).withOpacity(0.2)),
//             ),
//             child: Icon(icon, color: Color(0xFF4299E1), size: 30),
//           ),
//           SizedBox(height: 8),
//           Text(
//             text,
//             style: TextStyle(
//               color: Color(0xFF2D3748),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final employeeViewModel = Provider.of<EmployeeViewModel>(context);
//     final employee = employeeViewModel.currentEmployee;

//     return GestureDetector(
//       onTap: _showImagePickerModal,
//       onTapDown: (_) => _animationController.forward(),
//       onTapUp: (_) => _animationController.reverse(),
//       onTapCancel: () => _animationController.reverse(),
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Stack(
//           children: [
//             // Profile Image Container
//             Container(
//               width: widget.size,
//               height: widget.size,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF4299E1), Color(0xFF3182CE)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF4299E1).withOpacity(0.3),
//                     blurRadius: 15,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(4),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                   ),
//                   child: ClipOval(child: _buildImageContent(employee)),
//                 ),
//               ),
//             ),

//             // Upload Overlay
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: Container(
//                 width: widget.size * 0.3,
//                 height: widget.size * 0.3,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF4299E1),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 3),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: widget.size * 0.15,
//                 ),
//               ),
//             ),

//             // Loading Overlay - UPDATED: Use _isUploading instead of employeeViewModel.isLoading
//             if (_isUploading)
//               Positioned.fill(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageContent(Employee? employee) {
//     if (_imageFile != null) {
//       return Image.file(_imageFile!, fit: BoxFit.cover);
//     } else if (employee?.profileImageUrl != null &&
//         employee!.profileImageUrl!.isNotEmpty) {
//       return Image.network(
//         employee.profileImageUrl!,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return Center(
//             child: CircularProgressIndicator(
//               value: loadingProgress.expectedTotalBytes != null
//                   ? loadingProgress.cumulativeBytesLoaded /
//                       loadingProgress.expectedTotalBytes!
//                   : null,
//             ),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return _buildInitials(employee);
//         },
//       );
//     } else {
//       return _buildInitials(employee);
//     }
//   }

//   Widget _buildInitials(Employee? employee) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color(0xFFE2E8F0),
//       ),
//       child: Center(
//         child: Text(
//           employee != null
//               ? '${employee.firstName.isNotEmpty ? employee.firstName[0] : ''}'
//                   '${employee.lastName.isNotEmpty ? employee.lastName[0] : ''}'
//               : '?',
//           style: TextStyle(
//             fontSize: widget.size * 0.3,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF718096),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/employee_viewmodel.dart';

class ProfileImageUpload extends StatelessWidget {
  final String userId;
  final String? currentImageUrl;
  final double size;

  const ProfileImageUpload({
    super.key,
    required this.userId,
    this.currentImageUrl,
    this.size = 100,
  });

  get profileImageUrl => null;

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeViewModel>(
      builder: (context, viewModel, child) {
        ImageProvider? backgroundImage;

        // ✅ Display image based on platform
        if (kIsWeb && viewModel.webImage != null) {
          backgroundImage = MemoryImage(viewModel.webImage!);
        } else if (!kIsWeb && viewModel.profileImage != null) {
          backgroundImage = FileImage(viewModel.profileImage!);
        } else if (currentImageUrl != null && currentImageUrl!.isNotEmpty) {
          backgroundImage = NetworkImage(currentImageUrl!);
        }

        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: backgroundImage,
              child: backgroundImage == null
                  ? Icon(Icons.person, size: size / 4, color: Color(0xFF3182CE))
                  : null,
            ),
          ],
        );
      },
    );
  }
}
