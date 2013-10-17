Chef_Cookbook_Template
==========

Description
-----------
A template for Chef Cookbooks. Includes three gems: [chefspec](https://github.com/acrmp/chefspec), [fauxhai](https://github.com/customink/fauxhai), and [librarian-chef](https://github.com/applicationsonline/librarian).

Requirements
------------


Usage
-----
1. Clone this repo using `git clone git://github.com/Lytro/chef_cookbook_template.git YOUR_COOKBOOK_NAME`
2. Search and replace "chef_cookbook_template" with the name of your cookbook (preserve case if you want to be fancy)
3. Update the maintainer and maintainer_email in `metadata.rb`
4. Update YOUR_COMPANY_NAME towards the top of `recipes/default.rb`
5. Start TDD-ing your cookbook!

* If you want your specs to run against dependent cookbooks:
    1. add them to the `Cheffile`
    2. install them via `librarian-chef install`
    3. open `spec/spec_helper.rb`, then delete lines 11-13, 21 and 22, and uncomment lines 23 and 24.
* If you want to stub out dependent cookbooks and included recipes:
    1. open `spec/spec_helper.rb` and delete lines 22-24.
* If you don't have dependent cookbooks, then:
    1. open `spec/spec_helper.rb` and delete lines 11-13 and 22-24.

Note that when using ChefSpec and loading dependent cookbooks, you will be loading any cookbooks in directories parallel
to the current cookbook. This is because of the way Chef Solo works. In order to test cookbooks in isolation, you must move
them into their own directory. See https://github.com/acrmp/chefspec/issues/78.
