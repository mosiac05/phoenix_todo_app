export const uploadFileToS3Bucket = async (
  file,
  resolveCallback,
  rejectCallback
) => {
  let form = new FormData();

  form.append("Content-Type", file.type);
  form.append("file", file);

  // Get CSRFToken from the meta tag
  let csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content");

  let xhr = new XMLHttpRequest();
  // Send a POST request to the route `/uploads`
  // provided in the router and assigned a controller to
  // perform the request
  xhr.open("POST", "/s3-file-uploads", true);
  xhr.setRequestHeader("X-CSRF-Token", csrfToken);

  xhr.onerror = function (event) {
    rejectCallback("Unable to upload the file.");
  };

  xhr.onload = function () {
    if (xhr.status === 201) {
      // Get the full path of the uploaded file
      const fileUrl = xhr.responseText;
      resolveCallback(fileUrl);
    } else {
      rejectCallback("Unable to upload the file.");
    }
  };

  return xhr.send(form);
};
