<footer class="bg-white dark:bg-gray-800">
    <div class="w-full mx-auto max-w-screen-xl p-4 md:flex md:items-center md:justify-between">
      <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2024 <a href="https://flowbite.com/"
                                                                                      class="hover:underline">Devsync™</a>. All Rights Reserved.
    </span>
        <ul class="flex flex-wrap items-center mt-3 text-sm font-medium text-gray-500 dark:text-gray-400 sm:mt-0">
            <li>
                <a href="${pageContext.request.contextPath}" class="hover:underline me-4 md:me-6">About</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}" class="hover:underline me-4 md:me-6">Privacy Policy</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}" class="hover:underline me-4 md:me-6">Licensing</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}" class="hover:underline">Contact</a>
            </li>
        </ul>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Function to extract URL parameters
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    // Check if there's an error
    var errorMessage = getUrlParameter('error');
    if (errorMessage) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: errorMessage,
            confirmButtonText: 'OK',
            confirmButtonColor: '#3085d6'
        });
    }
    // Check if there's an info
    var infoMessage = getUrlParameter('info');
    if (infoMessage) {
        Swal.fire({
            icon: 'info',
            title: 'Info',
            position: 'top-end',
            toast: true,
            timer: 4000,
        });
    }
    // Check if there's a success
    var successMessage = getUrlParameter('success');
    if (successMessage) {
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: successMessage,
            position: 'top-end',
            toast: true,
            timer: 4000,
        });
    }
    // remove the error, info and success parameter from the URL but keep the rest of the parameters
    var currentUrl = new URL(window.location.href);
    currentUrl.searchParams.delete('success');
    currentUrl.searchParams.delete('info');
    currentUrl.searchParams.delete('error');
    window.history.replaceState({}, document.title, currentUrl.toString());
</script>