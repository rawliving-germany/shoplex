# Shoplex

Shoplex takes Shopware online shop order and invoice data and converts it in a format that Lexware can read to model open positions.

It superseedes the [magelex (version online is outdated)](github.com/raw-living-germany/magelex), since the change from Monstergento to Shopliftware.

It supports the management of cash flow in Lexware.

The solution is specific for one customers needs. If you need a similar (or better) solution, contact us!

## Installation

Install it yourself as:

    $ gem install shoplex

## Assumptions

Customer accounts are hard coded.

## Usage

  $ none yet

## Documentation of process



## Open questions and/or answers

*Which invoices or orders to take into account?*

Take **all invoices** (irrespective of orderStatus and paymentStatus)

*Some invoices have 0 amount and/or a gutschrift - where do they come from?*

**We don't know yet**

*Where is the tax of the shipping costs?*

The **invoiceAmount is inclusive the invoiceShipping**
Taxes of the shipping is not included in the individual tax columns but calculated via percentage (anteilsmäßig).

*Does Lexware needs gross or net numbers?*

Lexware takes **gross** numbers

*Do we need to book the discount?*

**We don't know yet**

## Other

To experiment with that code, run `bin/console` for an interactive prompt.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/raw-living-germany/shoplex. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/shoplex/blob/master/CODE_OF_CONDUCT.md).

### License

AGPLv3+, Copyright 2023 Felix wolfsteller

## Code of Conduct

Everyone interacting in the Shoplex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/raw-living-germany/shoplex/blob/master/CODE_OF_CONDUCT.md).
