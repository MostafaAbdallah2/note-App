import 'package:bloc_test/Api_Call/CRUD.dart';
import 'package:bloc_test/Api_Call/LinkApi.dart';
import 'package:bloc_test/main.dart';
import 'package:bloc_test/widget/addBage.dart';
import 'package:bloc_test/widget/editBage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestHome extends StatefulWidget {
  const RequestHome({super.key});

  @override
  State<RequestHome> createState() => _RequestHomeState();
}

class _RequestHomeState extends State<RequestHome> {
  Crud crud = Crud();
  Future<dynamic> ViewFunction() async {
    final email = sharedPerf.getString("Email");
    if (email == null || email.isEmpty) {
      return {"status": "error", "message": "missing email"};
    }

    var response = await crud.POST(ViewUrl, {"Email": email});
    return response;
  }

  Future<void> deleteNote(String id) async {
    var response = await crud.POST(DeleteUrl, {"id": id});


    if (response != null && response['status'] == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
      setState(() {});
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Delete failed")));
    }
  }

  Future<void> confirmDelete(String id) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBF7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          title: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9E7),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFE57373),
                ),
              ),
              SizedBox(width: 12.w),
              const Text("Delete note?"),
            ],
          ),
          content: const Text(
            "This note will be removed from your list.",
            style: TextStyle(color: Color(0xFF666666)),
          ),
          actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.delete_outline_rounded, size: 18),
              label: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await deleteNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("Home", (routes) => false);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: const Color(0xFFF5F0EB),
        title: Text(
          'My Notes📋',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "SF Pro Display",
            fontFamilyFallback: const ["SF Pro Text", "Helvetica Neue"],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: FutureBuilder(
          future: ViewFunction(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("We found problem in Request");
            }
            if (snapshot.hasData && snapshot.data["status"] == "success") {
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                shrinkWrap: true,

                itemBuilder: (context, i) {
                  return Card(
                    color: Color(0xFFF5F1EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),

                      leading: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD4A853), Color(0xFFF2D28B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4A853).withAlpha(70),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.sticky_note_2_rounded,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                            Positioned(
                              right: 8.w,
                              top: 8.w,
                              child: Container(
                                width: 7.w,
                                height: 7.w,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        "${snapshot.data['data'][i]['Title']}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,

                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      subtitle: Text(
                        "${snapshot.data['data'][i]["SupTitle"]}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xFF2D2D2D).withAlpha(150),
                        ),
                      ),
                      trailing: Material(
                        color: const Color(0xFFFFE9E7),
                        borderRadius: BorderRadius.circular(14.r),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14.r),
                          onTap: () async {
                            await confirmDelete(
                              snapshot.data['data'][i]['id'].toString(),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFE57373),
                            ),
                          ),
                        ),
                      ),

                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditBageNotes(
                              dataCell: snapshot.data['data'][i],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return Text("");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF5F0EB),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddNotePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
