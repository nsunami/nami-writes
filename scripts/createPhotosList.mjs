import { readdir } from "fs/promises";
import fs from "fs/promises";
import { extname } from "path";

async function getPhotos() {
	try {
		const files = await readdir(".");
		const photos = files.filter((file) =>
			[".jpg", ".jpeg", ".png"].includes(extname(file).toLowerCase())
		);

		const photoObjects = photos.map((photo) => ({ filename: photo }));
		await fs.writeFile("photos.json", JSON.stringify(photoObjects, null, 2));
		console.log("Photo list saved to photos.json");
	} catch (err) {
		console.error("Error reading directory:", err);
	}
}

getPhotos();
