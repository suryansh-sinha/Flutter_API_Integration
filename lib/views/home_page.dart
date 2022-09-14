import 'package:flutter/material.dart';
import 'package:rest_api_integration/models/post.dart';
import 'package:rest_api_integration/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Null safety -> By default, none of the variables declared can be null.
  // If your variable may contain a null value, you need to put a ? after the datatype.
  // Creating a list of objects from the Post class. It may be null.
  List<Post>? posts;
  var isLoaded = false;
  // Since null safety is enabled, you must initialize the non-null variables before you can use them.
  // I want to load the data when the page initialized and not repeat it on every build.
  @override // overriding the initState() function.
  void initState(){
    super.initState();

    //fetch data from API
    getData();
  }

  // Defining the getData() function used in the above function.
  // To use await keyword, the code must be inside an async function.
  // An async function must always return a future object.
  // A future object doesn't have an immediate value it does not stop all computation till it's value isn't retrieved.
  // It allows the rest of the program to function while it waits for it's value.
  // async --> Required if you want to do an asynchronous task inside your function.
  // await --> async function executes itself and stops until it encounters it's first await expression.
  // It only moves forward when the await expression gets it's value.
  getData() async {
    // Created RemoteService class in remote_call.dart file.
    // This fetches data from the internet.
    // Creating an object of the RemoteService class to call the getPosts Function.
    posts = await RemoteService().getPosts();
    // If the value that we get from the internet is not null, we set the isLoaded variable as true.
    if (posts != null){
      setState(() {
        isLoaded = true;  // If you get a valid post, set isLoaded to true.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Posts')
          ),
        backgroundColor: Colors.cyan,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
          ),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.cyan,
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          posts![index].body ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          ),
      )
    );
  }
}