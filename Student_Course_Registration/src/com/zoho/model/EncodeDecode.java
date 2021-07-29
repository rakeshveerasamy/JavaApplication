package com.zoho.model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.*;
import java.util.NoSuchElementException;

public class EncodeDecode {
	public static String encryptText(String text) 
	{
		Encoder encoder = Base64.getEncoder();
		String encodedString = encoder.encodeToString(text.getBytes());
		return encodedString;	
	}
	public static String decryptText(String text) 
	{
		Decoder decoder = Base64.getDecoder();
		byte[] bytes = decoder.decode(text);
		return (new String(bytes));
	}
	public static String encryptPass(String input) 
    {
            MessageDigest md = null;
			try {
				md = MessageDigest.getInstance("SHA-1");
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
    }
}
