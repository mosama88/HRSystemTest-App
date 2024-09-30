<!DOCTYPE html>
<html>

<head>
    <title>Edit User</title>
</head>

<body>
    <form action="{{ route('admin.update_user', $user->id) }}" method="POST">
        @csrf
        @method('PUT')

        <label for="license_expiry_date">License Expiry Date:</label>
        <input type="date" id="license_expiry_date" name="license_expiry_date" value="{{ $user->license_expiry_date }}">

        <button type="submit">Update</button>
    </form>
</body>

</html>
