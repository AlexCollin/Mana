const showNotification = function(type, message) {
    $.notify({
        icon: "add_alert",
        message: message

    }, {
        type: type,
        timer: 3000,
        placement: {
        from: "top",
        align: "right"
        }
    });
}