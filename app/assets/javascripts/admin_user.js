//角色管理
$(document).on('change', 'input.set-role:checked', function(e){
  $.ajax({
    url: "/admin/users/" + $(this).attr('name') + "/set_role",
    method: 'put',
    data: {
      role_id: $(this).val()
    }
  })
})
