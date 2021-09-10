
function activateForm(selform) {
  document.getElementById(selform).submit();
  //alert('activateForm!');
  return;
}

function closeMenu(caller) {

  if(caller.style.display == "block") {
    caller.style.display = "none";
    }
}

function toggleMenu( menuid, caller_element ) {
  var menu = document.getElementById(menuid);
  var caller = caller_element;

  if( document.all ) {
    //window.status="caller: " + caller.parentElement.style.left;
    menu.style.left = caller.parentElement.style.left;
  } else {
    //window.status="caller: " + caller.parentNode.style.left;
    menu.style.left = caller.parentNode.style.left;
  }

  if(menu.style.display == "block") {
    menu.style.display = "none";
  } else {
    menu.style.display = "block";
    menuList.add(menu);
  }

  return;
}

function closePopups( popups_string ) {

  var popups_list = popups_string.split(" ");
  i=0;
  while(i < popups_list.length) {
    menu = document.getElementById(popups_list[i]);
    i++;
    if(menu == null) continue;
    if(menu.style.display == "block")
      menu.style.display = "none";
  }
  window.status = popups_list[0];
  return;
}
