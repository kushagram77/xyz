package com.yash.onlinehomedecor.controller;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;

import com.yash.onlinehomedecor.domain.Order;
import com.yash.onlinehomedecor.service.OrderService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;

@Controller
public class PdfBillGenerationController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/order/bill/{orderId}")
    public ResponseEntity<byte[]> generateBillPdf(@PathVariable int orderId) {
        try {
            // Fetch order details
            Order order = orderService.getOrderById(orderId);

            // Create PDF
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // Add Company Header
            document.add(new Paragraph("Online Home Decor")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(20)
                    .setBold());

            document.add(new Paragraph("Invoice")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(16));

            // Invoice Details
            document.add(new Paragraph("Invoice Number: " + order.getId())
                    .setTextAlignment(TextAlignment.LEFT));

            // Format order date
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            document.add(new Paragraph("Date: " +
                    (order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "N/A"))
                    .setTextAlignment(TextAlignment.LEFT));

            // Customer Details
            document.add(new Paragraph("Customer Name: " + order.getCustomerName())
                    .setTextAlignment(TextAlignment.LEFT));
            document.add(new Paragraph("Shipping Address: " + order.getShippingAddress())
                    .setTextAlignment(TextAlignment.LEFT));

            // Create Order Items Table
            float[] columnWidths = {3, 2, 2, 2};
            Table table = new Table(columnWidths);
            table.setWidth(UnitValue.createPercentValue(100));

            // Table Headers
            table.addHeaderCell("Product Name");
            table.addHeaderCell("Quantity");
            table.addHeaderCell("Unit Price");
            table.addHeaderCell("Total");

            // Add Order Items
            double totalAmount = order.getQuantity() * order.getPrice();
            table.addCell(order.getProductName());
            table.addCell(String.valueOf(order.getQuantity()));
            table.addCell(String.format("₹%.2f", order.getPrice()));
            table.addCell(String.format("₹%.2f", totalAmount));

            // Add table to document
            document.add(table);

            // Total Calculations
            document.add(new Paragraph("Total Amount: ₹" + String.format("%.2f", totalAmount))
                    .setTextAlignment(TextAlignment.RIGHT)
                    .setFontSize(16)
                    .setBold());

            // Order Status
            document.add(new Paragraph("Order Status: " + order.getStatus())
                    .setTextAlignment(TextAlignment.LEFT));

            document.close();

            // Prepare HTTP response
            byte[] pdfBytes = baos.toByteArray();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("filename", "invoice_" + orderId + ".pdf");
            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(pdfBytes);

        } catch (Exception e) {
            // Log error
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
}