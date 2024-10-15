<style>
    section {
        min-height: 100vh !important;
    }


    .custom-radio-selector input[type="radio"] {
        display: none;
    }

    .custom-radio-selector label {
        display: block;
        padding: 0.5rem 1rem;
        cursor: pointer;
        transition: all 150ms ease-in-out;
    }

    .custom-radio-selector label:hover {
        background-color: #f3f4f6;
    }

    .dark .custom-radio-selector label:hover {
        background-color: #4b5563;
    }

    .custom-radio-selector input[type="radio"]:checked + label {
        color: #7ab3fa;
        border: 1px solid #215fad;
        border-radius: 10px;
    }

    .dark .custom-radio-selector input[type="radio"]:checked + label {
        background-color: #002280;
    }
</style>
<%@ page import="org.youcode.devsync.model.User" %>
<%@ page import="org.youcode.devsync.model.UserRole" %>
<%@ page import="org.youcode.devsync.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<header>
    <nav class="bg-white border-gray-200 px-4 py-2.5 dark:bg-gray-800">
        <div class="flex flex-wrap justify-between items-center mx-auto max-w-screen-xl">
            <a href="https://flowbite.com" class="flex items-center">
                <img src="https://raw.githubusercontent.com/abdelghani1002/Taskify-Frontend/refs/heads/main/src/assets/logo.png" class="mr-3 h-6 sm:h-9" alt="Flowbite Logo"/>
                <span class="self-center text-xl font-semibold whitespace-nowrap dark:text-white">DecSyncApp</span>
            </a>
            <div class="flex items-center lg:order-2">
                <%
                    if (user != null) {
                %>
                <div class="flex flex-row gap-2">
                    <div class="flex items-center gap-4">
                        <img class="w-10 h-10 rounded-full"
                             src="https://flowbite.com/docs/images/people/profile-picture-2.jpg" alt="">
                        <div class="font-medium dark:text-white">
                            <div>
                                ${user.username}
                                <span>
                                        <%
                                            if (user.getRole() == UserRole.manager) {
                                        %>
                                        <span class="bg-purple-500 text-white text-xs font-medium rounded-lg px-2 py-0.5">manager</span>
                                        <%
                                        } else {
                                        %>
                                        <span class="bg-blue-500 text-white text-xs font-medium rounded-lg px-2 py-0.5">user</span>
                                        <%
                                            }
                                        %>
                                    </span>
                            </div>
                            <div class="text-sm text-gray-500 dark:text-gray-400">${user.email}</div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/users?action=logout"
                       class="text-gray-800 dark:text-white hover:bg-gray-50 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-4 lg:px-5 py-2 lg:py-2.5 mr-2 dark:hover:bg-gray-700 focus:outline-none dark:focus:ring-gray-800">
                        Log out
                    </a>
                </div>
                <%
                } else {
                %>
                <a href="${pageContext.request.contextPath}/users?action=login"
                   class="text-gray-800 dark:text-white hover:bg-gray-50 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-4 lg:px-5 py-2 lg:py-2.5 mr-2 dark:hover:bg-gray-700 focus:outline-none dark:focus:ring-gray-800">
                    Log in
                </a>
                <a href="${pageContext.request.contextPath}/users?action=register"
                   class="text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-cyan-300 dark:focus:ring-cyan-800 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2">
                    Register
                </a>
                <%
                    }
                %>
            </div>
            <%
                if (user != null) {
            %>
            <div class="hidden justify-between items-center w-full lg:flex lg:w-auto lg:order-1" id="mobile-menu-2">
                <ul class="flex flex-col mt-4 font-medium lg:flex-row lg:space-x-8 lg:mt-0">
                    <li>
                        <a href="${pageContext.request.contextPath}"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Home
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/tasks"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Tasks
                        </a>
                    </li>
                    <%
                        if (user.getRole() == UserRole.manager) {
                    %>
                    <li>
                        <a href="${pageContext.request.contextPath}/tags"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Tags
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/statistics"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Statistics
                        </a>
                    </li>
                    <li class="pr-3">
                        <a href="${pageContext.request.contextPath}/users"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Users
                        </a>
                    </li>
                    <%
                        }
                    %>
                    <li>
                        <a href="${pageContext.request.contextPath}/requests"
                           class="block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">
                            Requests
                        </a>
                    </li>
                </ul>
            </div>
            <%
                }
            %>
        </div>
    </nav>
</header>
