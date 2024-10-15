<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="dark">
<head>
  <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
  <title>DevSync - Tags-edit</title>
</head>
<body>

<jsp:include page="../layouts/header.jsp"/>

<section class="bg-gray-50 dark:bg-gray-900 ">
  <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto">
    <div class="w-1/2 bg-white rounded-lg shadow dark:border md:mt-0 dark:bg-gray-800 dark:border-gray-700">
      <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
        <h1 class="text-center text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
          Create Tag
        </h1>
        <form class="space-y-4 md:space-y-6" action="${pageContext.request.contextPath}/tags?action=update" method="post">
            <input type="hidden" name="id" value="${tag.id}">
          <div>
            <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Enter Tag name</label>
            <input type="text" name="name" id="name" value="${tag.name}" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                   placeholder="Tag name" required="">
          </div>

          <button type="submit"
                  class="w-full text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
            Update
          </button>
        </form>
      </div>
    </div>
  </div>
</section>

<jsp:include page="../layouts/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
