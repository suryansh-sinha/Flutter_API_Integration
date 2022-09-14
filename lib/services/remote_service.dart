// A simple class that fetches data from the internet.
// Doing it separately just for separation of code.

import 'package:rest_api_integration/models/post.dart';
import 'package:http/http.dart' as http;  // Using the http package to fetch data from internet.

class RemoteService
{
  Future<List<Post>?> getPosts() async {
    var client = http.Client(); // Client object created.

    // Parsing the URL (splitting it into it's components)
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    // Using the client object, we are going request a response from API.
    var response = await client.get(uri);

    // Checking if the response was successful.
    if(response.statusCode == 200){
      var json = response.body; // Getting the body part of the json response.
      // Converting the JSON response to dart list.
      return postFromJson(json);  // This method is from the posts.dart file we created.
    }
  }
}