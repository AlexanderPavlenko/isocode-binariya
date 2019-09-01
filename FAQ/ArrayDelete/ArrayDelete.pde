int arr[] = new int[1024];
println(arr.length);
// ...
// тут происходит какая-то работа с массивом, затем он становится не нужен
// ...
arr = expand(arr, 0); 
println(arr.length);
