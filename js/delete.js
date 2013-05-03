function delete_actor(id) {
	var r=confirm("Are you sure you want to delete this actor?");
	if (r==true)
	{
		$.post("actor_delete.php",{todelete:id});
		return false;
	}
	else return true;
}

function delete_billinginfo(id, card) {
	var r=confirm("Are you sure you want to delete this billing information?");
	if (r==true)
	{
		$.post("delete_billinginfo.php",{todelete1:id, todelete2:card});
		return false;
	}
	else return true;
}

function delete_billingaddress(id) {
	var r=confirm("Are you sure you want to delete this billing address?");
	if (r==true)
	{
		$.post("delete_billingaddress.php",{todelete:id});
		return false;
	}
	else return true;
}

function delete_shippingaddress(id) {
	var r=confirm("Are you sure you want to delete this shipping address?");
	if (r==true)
	{
		$.post("delete_shippingaddress.php",{todelete:id});
		return false;
	}
	else return true;
}

function delete_actorrole(videoid, actorid) {
	var r=confirm("Are you sure you want to delete this actor role?");
	if (r==true)
	{
		$.post("delete_actorrole.php",{videoid:videoid,actorid:actorid});
		return false;
	}
	else return true;
}
