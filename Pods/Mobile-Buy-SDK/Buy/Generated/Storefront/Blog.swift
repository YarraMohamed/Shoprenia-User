//
//  Blog.swift
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
	/// An online store blog. 
	open class BlogQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Blog

		/// Find an article by its handle. 
		///
		/// - parameters:
		///     - handle: The handle of the article.
		///
		@discardableResult
		open func articleByHandle(alias: String? = nil, handle: String, _ subfields: (ArticleQuery) -> Void) -> BlogQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ArticleQuery()
			subfields(subquery)

			addField(field: "articleByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the blog's articles. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | author |
		///        | blog_title |
		///        | created_at |
		///        | tag |
		///        | tag_not |
		///        | updated_at |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func articles(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ArticleSortKeys? = nil, query: String? = nil, _ subfields: (ArticleConnectionQuery) -> Void) -> BlogQuery {
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

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ArticleConnectionQuery()
			subfields(subquery)

			addField(field: "articles", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The authors who have contributed to the blog. 
		@discardableResult
		open func authors(alias: String? = nil, _ subfields: (ArticleAuthorQuery) -> Void) -> BlogQuery {
			let subquery = ArticleAuthorQuery()
			subfields(subquery)

			addField(field: "authors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A human-friendly unique string for the Blog automatically generated from 
		/// its title. 
		@discardableResult
		open func handle(alias: String? = nil) -> BlogQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> BlogQuery {
			addField(field: "id", aliasSuffix: alias)
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
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> BlogQuery {
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
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> BlogQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> BlogQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// The blog's SEO information. 
		@discardableResult
		open func seo(alias: String? = nil, _ subfields: (SEOQuery) -> Void) -> BlogQuery {
			let subquery = SEOQuery()
			subfields(subquery)

			addField(field: "seo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The blogs’s title. 
		@discardableResult
		open func title(alias: String? = nil) -> BlogQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// An online store blog. 
	open class Blog: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MenuItemResource, MetafieldParentResource, Node, OnlineStorePublishable {
		public typealias Query = BlogQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "articleByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try Article(fields: value)

				case "articles":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try ArticleConnection(fields: value)

				case "authors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ArticleAuthor(fields: $0) }

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "seo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return try SEO(fields: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Blog.self, field: fieldName, value: fieldValue)
			}
		}

		/// Find an article by its handle. 
		open var articleByHandle: Storefront.Article? {
			return internalGetArticleByHandle()
		}

		open func aliasedArticleByHandle(alias: String) -> Storefront.Article? {
			return internalGetArticleByHandle(alias: alias)
		}

		func internalGetArticleByHandle(alias: String? = nil) -> Storefront.Article? {
			return field(field: "articleByHandle", aliasSuffix: alias) as! Storefront.Article?
		}

		/// List of the blog's articles. 
		open var articles: Storefront.ArticleConnection {
			return internalGetArticles()
		}

		open func aliasedArticles(alias: String) -> Storefront.ArticleConnection {
			return internalGetArticles(alias: alias)
		}

		func internalGetArticles(alias: String? = nil) -> Storefront.ArticleConnection {
			return field(field: "articles", aliasSuffix: alias) as! Storefront.ArticleConnection
		}

		/// The authors who have contributed to the blog. 
		open var authors: [Storefront.ArticleAuthor] {
			return internalGetAuthors()
		}

		func internalGetAuthors(alias: String? = nil) -> [Storefront.ArticleAuthor] {
			return field(field: "authors", aliasSuffix: alias) as! [Storefront.ArticleAuthor]
		}

		/// A human-friendly unique string for the Blog automatically generated from 
		/// its title. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
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

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		/// The blog's SEO information. 
		open var seo: Storefront.SEO? {
			return internalGetSeo()
		}

		func internalGetSeo(alias: String? = nil) -> Storefront.SEO? {
			return field(field: "seo", aliasSuffix: alias) as! Storefront.SEO?
		}

		/// The blogs’s title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "articleByHandle":
					if let value = internalGetArticleByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "articles":
					response.append(internalGetArticles())
					response.append(contentsOf: internalGetArticles().childResponseObjectMap())

					case "authors":
					internalGetAuthors().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
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

					case "seo":
					if let value = internalGetSeo() {
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
