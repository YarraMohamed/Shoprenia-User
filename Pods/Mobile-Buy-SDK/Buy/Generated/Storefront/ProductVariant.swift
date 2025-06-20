//
//  ProductVariant.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Storefront {
	/// A product variant represents a different version of a product, such as 
	/// differing sizes or differing colors. 
	open class ProductVariantQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductVariant

		/// Indicates if the product variant is available for sale. 
		@discardableResult
		open func availableForSale(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "availableForSale", aliasSuffix: alias)
			return self
		}

		/// The barcode (for example, ISBN, UPC, or GTIN) associated with the variant. 
		@discardableResult
		open func barcode(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "barcode", aliasSuffix: alias)
			return self
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPrice` is higher than `price`. 
		@discardableResult
		open func compareAtPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "compareAtPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPriceV2` is higher than `priceV2`. 
		@available(*, deprecated, message: "Use `compareAtPrice` instead.")
		@discardableResult
		open func compareAtPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "compareAtPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of bundles components included in the variant considering only fixed 
		/// bundles. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///
		@discardableResult
		open func components(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, _ subfields: (ProductVariantComponentConnectionQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantComponentConnectionQuery()
			subfields(subquery)

			addField(field: "components", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Whether a product is out of stock but still available for purchase (used 
		/// for backorders). 
		@discardableResult
		open func currentlyNotInStock(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "currentlyNotInStock", aliasSuffix: alias)
			return self
		}

		/// List of bundles that include this variant considering only fixed bundles. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///
		@discardableResult
		open func groupedBy(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, _ subfields: (ProductVariantConnectionQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantConnectionQuery()
			subfields(subquery)

			addField(field: "groupedBy", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Image associated with the product variant. This field falls back to the 
		/// product image if no image is available. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> ProductVariantQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The product variant’s price. 
		@discardableResult
		open func price(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "price", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The product variant’s price. 
		@available(*, deprecated, message: "Use `price` instead.")
		@discardableResult
		open func priceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "priceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The product object that the product variant belongs to. 
		@discardableResult
		open func product(alias: String? = nil, _ subfields: (ProductQuery) -> Void) -> ProductVariantQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "product", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total sellable quantity of the variant for online sales channels. 
		@discardableResult
		open func quantityAvailable(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "quantityAvailable", aliasSuffix: alias)
			return self
		}

		/// A list of quantity breaks for the product variant. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///
		@discardableResult
		open func quantityPriceBreaks(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, _ subfields: (QuantityPriceBreakConnectionQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = QuantityPriceBreakConnectionQuery()
			subfields(subquery)

			addField(field: "quantityPriceBreaks", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The quantity rule for the product variant in a given context. 
		@discardableResult
		open func quantityRule(alias: String? = nil, _ subfields: (QuantityRuleQuery) -> Void) -> ProductVariantQuery {
			let subquery = QuantityRuleQuery()
			subfields(subquery)

			addField(field: "quantityRule", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether a product variant requires components. The default value is 
		/// `false`. If `true`, then the product variant can only be purchased as a 
		/// parent bundle with components. 
		@discardableResult
		open func requiresComponents(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "requiresComponents", aliasSuffix: alias)
			return self
		}

		/// Whether a customer needs to provide a shipping address when placing an 
		/// order for the product variant. 
		@discardableResult
		open func requiresShipping(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "requiresShipping", aliasSuffix: alias)
			return self
		}

		/// List of product options applied to the variant. 
		@discardableResult
		open func selectedOptions(alias: String? = nil, _ subfields: (SelectedOptionQuery) -> Void) -> ProductVariantQuery {
			let subquery = SelectedOptionQuery()
			subfields(subquery)

			addField(field: "selectedOptions", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Represents an association between a variant and a selling plan. Selling 
		/// plan allocations describe which selling plans are available for each 
		/// variant, and what their impact is on pricing. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func sellingPlanAllocations(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (SellingPlanAllocationConnectionQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = SellingPlanAllocationConnectionQuery()
			subfields(subquery)

			addField(field: "sellingPlanAllocations", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The Shop Pay Installments pricing information for the product variant. 
		@discardableResult
		open func shopPayInstallmentsPricing(alias: String? = nil, _ subfields: (ShopPayInstallmentsProductVariantPricingQuery) -> Void) -> ProductVariantQuery {
			let subquery = ShopPayInstallmentsProductVariantPricingQuery()
			subfields(subquery)

			addField(field: "shopPayInstallmentsPricing", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The SKU (stock keeping unit) associated with the variant. 
		@discardableResult
		open func sku(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "sku", aliasSuffix: alias)
			return self
		}

		/// The in-store pickup availability of this variant by location. 
		///
		/// - parameters:
		///     - near: Used to sort results based on proximity to the provided location.
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func storeAvailability(alias: String? = nil, near: GeoCoordinateInput? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (StoreAvailabilityConnectionQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let near = near {
				args.append("near:\(near.serialize())")
			}

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = StoreAvailabilityConnectionQuery()
			subfields(subquery)

			addField(field: "storeAvailability", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Whether tax is charged when the product variant is sold. 
		@discardableResult
		open func taxable(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "taxable", aliasSuffix: alias)
			return self
		}

		/// The product variant’s title. 
		@discardableResult
		open func title(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The unit price value for the variant based on the variant's measurement. 
		@discardableResult
		open func unitPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "unitPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The unit price measurement for the variant. 
		@discardableResult
		open func unitPriceMeasurement(alias: String? = nil, _ subfields: (UnitPriceMeasurementQuery) -> Void) -> ProductVariantQuery {
			let subquery = UnitPriceMeasurementQuery()
			subfields(subquery)

			addField(field: "unitPriceMeasurement", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The weight of the product variant in the unit system specified with 
		/// `weight_unit`. 
		@discardableResult
		open func weight(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "weight", aliasSuffix: alias)
			return self
		}

		/// Unit of measurement for weight. 
		@discardableResult
		open func weightUnit(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "weightUnit", aliasSuffix: alias)
			return self
		}
	}

	/// A product variant represents a different version of a product, such as 
	/// differing sizes or differing colors. 
	open class ProductVariant: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, Merchandise, MetafieldParentResource, MetafieldReference, Node {
		public typealias Query = ProductVariantQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "availableForSale":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "barcode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "compareAtPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "compareAtPriceV2":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "components":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariantComponentConnection(fields: value)

				case "currentlyNotInStock":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "groupedBy":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariantConnection(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "price":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "priceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "product":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "quantityAvailable":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "quantityPriceBreaks":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try QuantityPriceBreakConnection(fields: value)

				case "quantityRule":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try QuantityRule(fields: value)

				case "requiresComponents":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "requiresShipping":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "selectedOptions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SelectedOption(fields: $0) }

				case "sellingPlanAllocations":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlanAllocationConnection(fields: value)

				case "shopPayInstallmentsPricing":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayInstallmentsProductVariantPricing(fields: value)

				case "sku":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "storeAvailability":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try StoreAvailabilityConnection(fields: value)

				case "taxable":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "unitPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "unitPriceMeasurement":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try UnitPriceMeasurement(fields: value)

				case "weight":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "weightUnit":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return WeightUnit(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
			}
		}

		/// Indicates if the product variant is available for sale. 
		open var availableForSale: Bool {
			return internalGetAvailableForSale()
		}

		func internalGetAvailableForSale(alias: String? = nil) -> Bool {
			return field(field: "availableForSale", aliasSuffix: alias) as! Bool
		}

		/// The barcode (for example, ISBN, UPC, or GTIN) associated with the variant. 
		open var barcode: String? {
			return internalGetBarcode()
		}

		func internalGetBarcode(alias: String? = nil) -> String? {
			return field(field: "barcode", aliasSuffix: alias) as! String?
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPrice` is higher than `price`. 
		open var compareAtPrice: Storefront.MoneyV2? {
			return internalGetCompareAtPrice()
		}

		func internalGetCompareAtPrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "compareAtPrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPriceV2` is higher than `priceV2`. 
		@available(*, deprecated, message: "Use `compareAtPrice` instead.")
		open var compareAtPriceV2: Storefront.MoneyV2? {
			return internalGetCompareAtPriceV2()
		}

		func internalGetCompareAtPriceV2(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "compareAtPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// List of bundles components included in the variant considering only fixed 
		/// bundles. 
		open var components: Storefront.ProductVariantComponentConnection {
			return internalGetComponents()
		}

		open func aliasedComponents(alias: String) -> Storefront.ProductVariantComponentConnection {
			return internalGetComponents(alias: alias)
		}

		func internalGetComponents(alias: String? = nil) -> Storefront.ProductVariantComponentConnection {
			return field(field: "components", aliasSuffix: alias) as! Storefront.ProductVariantComponentConnection
		}

		/// Whether a product is out of stock but still available for purchase (used 
		/// for backorders). 
		open var currentlyNotInStock: Bool {
			return internalGetCurrentlyNotInStock()
		}

		func internalGetCurrentlyNotInStock(alias: String? = nil) -> Bool {
			return field(field: "currentlyNotInStock", aliasSuffix: alias) as! Bool
		}

		/// List of bundles that include this variant considering only fixed bundles. 
		open var groupedBy: Storefront.ProductVariantConnection {
			return internalGetGroupedBy()
		}

		open func aliasedGroupedBy(alias: String) -> Storefront.ProductVariantConnection {
			return internalGetGroupedBy(alias: alias)
		}

		func internalGetGroupedBy(alias: String? = nil) -> Storefront.ProductVariantConnection {
			return field(field: "groupedBy", aliasSuffix: alias) as! Storefront.ProductVariantConnection
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Image associated with the product variant. This field falls back to the 
		/// product image if no image is available. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		/// The product variant’s price. 
		open var price: Storefront.MoneyV2 {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "price", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The product variant’s price. 
		@available(*, deprecated, message: "Use `price` instead.")
		open var priceV2: Storefront.MoneyV2 {
			return internalGetPriceV2()
		}

		func internalGetPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "priceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The product object that the product variant belongs to. 
		open var product: Storefront.Product {
			return internalGetProduct()
		}

		func internalGetProduct(alias: String? = nil) -> Storefront.Product {
			return field(field: "product", aliasSuffix: alias) as! Storefront.Product
		}

		/// The total sellable quantity of the variant for online sales channels. 
		open var quantityAvailable: Int32? {
			return internalGetQuantityAvailable()
		}

		func internalGetQuantityAvailable(alias: String? = nil) -> Int32? {
			return field(field: "quantityAvailable", aliasSuffix: alias) as! Int32?
		}

		/// A list of quantity breaks for the product variant. 
		open var quantityPriceBreaks: Storefront.QuantityPriceBreakConnection {
			return internalGetQuantityPriceBreaks()
		}

		open func aliasedQuantityPriceBreaks(alias: String) -> Storefront.QuantityPriceBreakConnection {
			return internalGetQuantityPriceBreaks(alias: alias)
		}

		func internalGetQuantityPriceBreaks(alias: String? = nil) -> Storefront.QuantityPriceBreakConnection {
			return field(field: "quantityPriceBreaks", aliasSuffix: alias) as! Storefront.QuantityPriceBreakConnection
		}

		/// The quantity rule for the product variant in a given context. 
		open var quantityRule: Storefront.QuantityRule {
			return internalGetQuantityRule()
		}

		func internalGetQuantityRule(alias: String? = nil) -> Storefront.QuantityRule {
			return field(field: "quantityRule", aliasSuffix: alias) as! Storefront.QuantityRule
		}

		/// Whether a product variant requires components. The default value is 
		/// `false`. If `true`, then the product variant can only be purchased as a 
		/// parent bundle with components. 
		open var requiresComponents: Bool {
			return internalGetRequiresComponents()
		}

		func internalGetRequiresComponents(alias: String? = nil) -> Bool {
			return field(field: "requiresComponents", aliasSuffix: alias) as! Bool
		}

		/// Whether a customer needs to provide a shipping address when placing an 
		/// order for the product variant. 
		open var requiresShipping: Bool {
			return internalGetRequiresShipping()
		}

		func internalGetRequiresShipping(alias: String? = nil) -> Bool {
			return field(field: "requiresShipping", aliasSuffix: alias) as! Bool
		}

		/// List of product options applied to the variant. 
		open var selectedOptions: [Storefront.SelectedOption] {
			return internalGetSelectedOptions()
		}

		func internalGetSelectedOptions(alias: String? = nil) -> [Storefront.SelectedOption] {
			return field(field: "selectedOptions", aliasSuffix: alias) as! [Storefront.SelectedOption]
		}

		/// Represents an association between a variant and a selling plan. Selling 
		/// plan allocations describe which selling plans are available for each 
		/// variant, and what their impact is on pricing. 
		open var sellingPlanAllocations: Storefront.SellingPlanAllocationConnection {
			return internalGetSellingPlanAllocations()
		}

		open func aliasedSellingPlanAllocations(alias: String) -> Storefront.SellingPlanAllocationConnection {
			return internalGetSellingPlanAllocations(alias: alias)
		}

		func internalGetSellingPlanAllocations(alias: String? = nil) -> Storefront.SellingPlanAllocationConnection {
			return field(field: "sellingPlanAllocations", aliasSuffix: alias) as! Storefront.SellingPlanAllocationConnection
		}

		/// The Shop Pay Installments pricing information for the product variant. 
		open var shopPayInstallmentsPricing: Storefront.ShopPayInstallmentsProductVariantPricing? {
			return internalGetShopPayInstallmentsPricing()
		}

		func internalGetShopPayInstallmentsPricing(alias: String? = nil) -> Storefront.ShopPayInstallmentsProductVariantPricing? {
			return field(field: "shopPayInstallmentsPricing", aliasSuffix: alias) as! Storefront.ShopPayInstallmentsProductVariantPricing?
		}

		/// The SKU (stock keeping unit) associated with the variant. 
		open var sku: String? {
			return internalGetSku()
		}

		func internalGetSku(alias: String? = nil) -> String? {
			return field(field: "sku", aliasSuffix: alias) as! String?
		}

		/// The in-store pickup availability of this variant by location. 
		open var storeAvailability: Storefront.StoreAvailabilityConnection {
			return internalGetStoreAvailability()
		}

		open func aliasedStoreAvailability(alias: String) -> Storefront.StoreAvailabilityConnection {
			return internalGetStoreAvailability(alias: alias)
		}

		func internalGetStoreAvailability(alias: String? = nil) -> Storefront.StoreAvailabilityConnection {
			return field(field: "storeAvailability", aliasSuffix: alias) as! Storefront.StoreAvailabilityConnection
		}

		/// Whether tax is charged when the product variant is sold. 
		open var taxable: Bool {
			return internalGetTaxable()
		}

		func internalGetTaxable(alias: String? = nil) -> Bool {
			return field(field: "taxable", aliasSuffix: alias) as! Bool
		}

		/// The product variant’s title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The unit price value for the variant based on the variant's measurement. 
		open var unitPrice: Storefront.MoneyV2? {
			return internalGetUnitPrice()
		}

		func internalGetUnitPrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "unitPrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The unit price measurement for the variant. 
		open var unitPriceMeasurement: Storefront.UnitPriceMeasurement? {
			return internalGetUnitPriceMeasurement()
		}

		func internalGetUnitPriceMeasurement(alias: String? = nil) -> Storefront.UnitPriceMeasurement? {
			return field(field: "unitPriceMeasurement", aliasSuffix: alias) as! Storefront.UnitPriceMeasurement?
		}

		/// The weight of the product variant in the unit system specified with 
		/// `weight_unit`. 
		open var weight: Double? {
			return internalGetWeight()
		}

		func internalGetWeight(alias: String? = nil) -> Double? {
			return field(field: "weight", aliasSuffix: alias) as! Double?
		}

		/// Unit of measurement for weight. 
		open var weightUnit: Storefront.WeightUnit {
			return internalGetWeightUnit()
		}

		func internalGetWeightUnit(alias: String? = nil) -> Storefront.WeightUnit {
			return field(field: "weightUnit", aliasSuffix: alias) as! Storefront.WeightUnit
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "compareAtPrice":
					if let value = internalGetCompareAtPrice() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "compareAtPriceV2":
					if let value = internalGetCompareAtPriceV2() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "components":
					response.append(internalGetComponents())
					response.append(contentsOf: internalGetComponents().childResponseObjectMap())

					case "groupedBy":
					response.append(internalGetGroupedBy())
					response.append(contentsOf: internalGetGroupedBy().childResponseObjectMap())

					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					case "price":
					response.append(internalGetPrice())
					response.append(contentsOf: internalGetPrice().childResponseObjectMap())

					case "priceV2":
					response.append(internalGetPriceV2())
					response.append(contentsOf: internalGetPriceV2().childResponseObjectMap())

					case "product":
					response.append(internalGetProduct())
					response.append(contentsOf: internalGetProduct().childResponseObjectMap())

					case "quantityPriceBreaks":
					response.append(internalGetQuantityPriceBreaks())
					response.append(contentsOf: internalGetQuantityPriceBreaks().childResponseObjectMap())

					case "quantityRule":
					response.append(internalGetQuantityRule())
					response.append(contentsOf: internalGetQuantityRule().childResponseObjectMap())

					case "selectedOptions":
					internalGetSelectedOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "sellingPlanAllocations":
					response.append(internalGetSellingPlanAllocations())
					response.append(contentsOf: internalGetSellingPlanAllocations().childResponseObjectMap())

					case "shopPayInstallmentsPricing":
					if let value = internalGetShopPayInstallmentsPricing() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "storeAvailability":
					response.append(internalGetStoreAvailability())
					response.append(contentsOf: internalGetStoreAvailability().childResponseObjectMap())

					case "unitPrice":
					if let value = internalGetUnitPrice() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "unitPriceMeasurement":
					if let value = internalGetUnitPriceMeasurement() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
