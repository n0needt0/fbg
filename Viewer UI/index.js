var menuList = 
[
	{name : "Location", list : ["San Mateo", "San Francisco", "San Jose", "Berkeley", "Stanford", "Oakland"]},
	{name : "Date", list : ["2/17/13", "7/3/14", "11/18/14", "2/25/12"]}
];

var app = angular.module("fileRoom", ["ngRoute"]);

var menuController = app.controller("MenuController", function()
{
	this.items = menuList;
});

var tabController = app.controller("TabController", function()
{
	this.selected = 1;
	this.select = function(numTab)
	{
		this.selected = numTab;
	};
	this.isSelected = function(numTab)
	{
		return this.selected === numTab;
	};
})

$(document).ready(function()
{
	$('.dropdown').click(function()
	{
		$(this).dropdown('toggle');
	});
});