-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bosart
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bosart` ;

-- -----------------------------------------------------
-- Schema bosart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bosart` DEFAULT CHARACTER SET utf8 ;
USE `bosart` ;

-- -----------------------------------------------------
-- Table `bosart`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`location` ;

CREATE TABLE IF NOT EXISTS `bosart`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `neighborhood` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`size` ;

CREATE TABLE IF NOT EXISTS `bosart`.`size` (
  `size_id` INT NOT NULL AUTO_INCREMENT,
  `size` ENUM('small', 'medium', 'large', 'extra large') NOT NULL,
  PRIMARY KEY (`size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art` (
  `public_art_id` INT NOT NULL AUTO_INCREMENT,
  `existence` TINYINT NOT NULL,
  `time` DATETIME NULL,
  `description` VARCHAR(1500) NULL,
  `location_id` INT NOT NULL,
  `size_id` INT NOT NULL,
  `title` VARCHAR(50) NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`public_art_id`),
  INDEX `fk_public_art_location_idx` (`location_id` ASC),
  INDEX `fk_public_art_size1_idx` (`size_id` ASC),
  CONSTRAINT `fk_public_art_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `bosart`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_size1`
    FOREIGN KEY (`size_id`)
    REFERENCES `bosart`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`genre` ;

CREATE TABLE IF NOT EXISTS `bosart`.`genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `medium` VARCHAR(30) NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`artist` ;

CREATE TABLE IF NOT EXISTS `bosart`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(30) NULL,
  `lastname` VARCHAR(30) NULL,
  `biography` VARCHAR(300) NULL,
  `dob` DATE NULL,
  `link` VARCHAR(100) NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art_has_artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art_has_artist` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art_has_artist` (
  `public_art_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`public_art_id`, `artist_id`),
  INDEX `fk_public_art_has_artist_artist1_idx` (`artist_id` ASC),
  INDEX `fk_public_art_has_artist_public_art1_idx` (`public_art_id` ASC),
  CONSTRAINT `fk_public_art_has_artist_public_art1`
    FOREIGN KEY (`public_art_id`)
    REFERENCES `bosart`.`public_art` (`public_art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_has_artist_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `bosart`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art_has_genre` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art_has_genre` (
  `public_art_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`public_art_id`, `genre_id`),
  INDEX `fk_public_art_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_public_art_has_genre_public_art1_idx` (`public_art_id` ASC),
  CONSTRAINT `fk_public_art_has_genre_public_art1`
    FOREIGN KEY (`public_art_id`)
    REFERENCES `bosart`.`public_art` (`public_art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `bosart`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





use bosart;


insert into artist(firstname, lastname) values 
('Augustus', 'Saint-Gaudens'),
('Stanley', 'Saitowitz'), 
('Nancy', 'Schön'), 
('Louis D. Brown Peace Institute', null), 
('Lilli Ann Killen', 'Rosenberg'),
('Araldo', 'Cossutta'), 
('Corita',  'Kent'),
('Arthur', 'Gagner'),
('Susumu', 'Shingu'),
('Solomon', 'Willard'),
('Arrigo', 'Minerbi'),
('Matt', 'Hincman'),
('Lego Master Model Builders', null),
('Mayor\'s Mural Crew', null),
('Rafael Rivera', 'Garcia'),
('Richard "Deme5"', 'Gomez'), 
('Thomas "Kwest"', 'Burns'),
('George', 'Rhoads'),
('Louis Paul Jonas Studios', null),
('Bostonian Society', null),
('Paul', 'Matisse'),
('Boston Women’s Heritage Trail', null),
('Mayor\'s Mural Crew', null),
('Kim', 'Giordano'),
('Nicholas', 'Shaplyko'),
('Ekaterina', 'Sorokina'),
('El Mac', null),
('Liz', 'LaManche');

insert into genre(medium) values 
('Memorial'),
('Sculpture'),
('Graffiti'),
('Statue'),
('Mural'),
('Vehicle'),
('Historic Site'),
('Sign'),
('Bench'),
('Kinetic Art'),
('Plaque');

insert into size(size) values
('small'),
('medium'),
('large'),
('extra large');

insert into location(neighborhood, address) values
('Beacon Hill', 'On Boston Common, along Beacon Street at Park Street, across from the State House'),
('South Boston', 'On Congress Street between Hanover and North streets, Boston'),
('Back Bay', 'At Boston Public Garden, near Beacon and Charles streets'),
('Cambridge', 'Modica Way, next to 567 Massachuesetts Ave., Central Square, Cambridge'),
('N/A', 'Various locations around Boston'),
('Saugus', 'Route 1, Saugus'), 
('South End', 'At Villa Victoria, Aguadilla Street, off Tremont Street, Boston'),
('Back Bay', 'Boston Public Garden pond'),
('Boston', 'Boston Common to Bunker Hill'),
('Fenway', 'At 660 Beacon St., Kenmore Square, Boston'),
('Fenway', 'At Christian Science Plaza, Huntington Avenue, Boston'),
('Dorchester', 'On Victory Road at Boston Harbor, Dorchester, Boston'),
('Jamaica Plain', 'Outside the Boston Children\'s Museum, 308 Congress St.'),
('Cambridge', 'At Porter Square, Cambridge'),
('Charlestown', 'At Monument Square, Charlestown'), 
('East Boston', 'At 150 Orient Ave., East Boston'),
('Jamaica Plain', 'At Jamaica Pond, near Pond St, Boston'), 
('Somerville', 'At Legoland Discovery Center, 598 Assembly Row, Somerville'), 
('Jamaica Plain', 'On Purple Cactus, 674 Centre St., Boston'), 
('Jamaica Plain', 'Perkins Street off Centre Street, behind Whole Foods'),
('Roxbury', 'On Warren Street at Clifford Street, Boston'),
('East Cambridge', 'At Boston Museum of Science lobby, 1 Science Park'), 
('East Cambridge', 'Outside Museum of Science, 1 Science Park, Boston'), 
('Downtown', 'In front of Old State House, Devonshire Street at State Street'),
('Bunker Hill', 'Paul Revere Park, Boston'),
('Chinatown', 'Corner of Tyler and Beach streets, Chinatown'),
('Jamaica Plain', '2 Harris Ave., at Centre Street'),
('Dorchester', 'Atop Expressway Toyota, 700 Morrissey Blvd., Boston'),
('Somerville', '115 College Ave., Somerville'),
('Fenway', 'On Northeastern University\'s Meserve Hall, 35-37 Leon St., Boston'), 
('East Boston', 'At HarborArts, 256 Marginal St., East Boston');

insert into public_art(existence, time, description, location_id, size_id, title, image) values
(1, '1897-05-31', 'The Memorial to Robert Gould Shaw and the Massachusetts 
Fifty-Fourth Regiment is a bronze relief sculpture by Augustus Saint-Gaudens at 24 Beacon Street, Boston 
(at the edge of the Boston Common), depicting Col. Shaw and the 54th Regiment Massachusetts Volunteer
 Infantry, marching down Beacon Street on May 28, 1863. It was unveiled May 31, 1897.
 It has been acclaimed as the greatest American sculpture of the 19th century. ', 1,  2, 'Shaw Memorial',  LOAD_FILE('/Users/homefolder/Desktop/db/boston_art/images/1.jpg')),
(1, '1995-01-01', 'Stephan Ross was just 9 years old when he was imprisoned by the Nazis. Between 1940 and 1945, 
he survived 10 different concentration camps, while his parents, a brother and five sisters were murdered. 
“His back was broken by a guard who caught him stealing a raw potato,” 
the monument’s website explains. At 14, he was finally freed from Dachau by American troops. 
He came to the U.S. in 1948 via the U.S. Committee for Orphaned Children, went to college,
 and worked for the city of Boston for decades, “providing guidance and clinical services to inner-city youth and families.” 
 Late in life, Ross, along with other camp survivors in Boston, proposed a monument to the Holocaust here. 
 Designed by architect Stanley Saitowitz, a row of six 54-foot-tall glass towers hauntingly evoke the smokestacks of the six main Nazi concentration camps in Poland. 
 Their glass is etched with millions of numbers like those tattooed on death camp prisoners. 
 The monument invites you to walk along a path among and into the towers.', 2, 4, 'New England Holocaust Memorial', LOAD_FILE('/boston_art/images/2.jpg')),
(1, '1987-10-04', 'The children’s book author and illustrator Robert McCloskey won his first Caledecott Medal for his 1941 book “Make Way for Ducklings” 
about a family of ducks that make their way from a nest at the Charles River to a new home on the island in the Boston Public Garden’s pond — with police directing traffic along the way. 
Urban planner Suzanne DeMonchaux thought it would make a great public sculpture for Boston — modeling how cities can be more friendly to children.', 3, 1, 'Make Way for Ducklings', LOAD_FILE('/boston_art/images/3.jpg')),
(1, '2007-01-01', 'In fall 2007, Central Kitchen owner Gary Strack and financial adviser-turned-artist Geoff Hargadon transformed the exterior wall of the restaurant into a place where graffiti is welcomed rather than buffed. 
One of the rare places in the region where graffiti can be done legally. ', 4, 3, 'Graffiti Wall', LOAD_FILE('/boston_art/images/4.jpg')), 
(1, '1994-01-01', 'A stray bullet from a shootout between men on a December afternoon in 1993 hit Tina Chéry’s 15-year-old son. 
“A friend of mine for Louis’ funeral created some buttons that said ‘Save the children,’” Chéry says. “After he was laid to rest, I didn’t know what I could do.” 
She began making buttons to memorialize other homicide victims that she read about in the newspaper. 
She’d send them to the reporters who wrote the articles and ask them to pass the buttons along to the families.', 5, 1, 'Memorial Buttons', LOAD_FILE('/boston_art/images/5.jpg')),
(1, '1960-01-01', 'The 12-foot-tall, dayglo orange T-rex was installed around 1960 to attract business to the entertainment complex. It has become a beloved regional landmark — fun, funny, monumental, orange. 
But the iconic sculpture’s status is threatened after Lynnfield developer Michael Touchette proposed building a complex of apartments, restaurants, 
hotels and retail space on the three-acre property, which has been home to mini golf since 1958, and adjoining land.', 6, 2, 'Orange Dinosaur', LOAD_FILE('/boston_art/images/6.jpg')),
(1, '1979-01-01', 'A pair of brilliant suns, that also can be read as islands, radiate from either end of this 45-foot-long ceramic mosaic. 
It celebrates the Puerto Rican heritage of many residents of Inquilinos Boricuas en Acción’s Villa Victoria housing in Boston’s South End, 
which arose out of late 1960s activism to prevent the displacement of the neighborhood’s residents.', 7, 3, 'Betances Mural', LOAD_FILE('/boston_art/images/7.jpg')),
(1, '1877-01-01', 'In 1877, Robert Paget, who had operated boat tours for a few years on the Public Garden’s pond, 
came up with a new foot-powered paddle-wheel catamaran inspired by bicycles. As a pretty way to conceal the vessel’s laboring pilot, he thought of an opera — 
Richard Wagner’s mid 19th century "Lohengrin," with its tale of a knight crossing a river in a boat pulled by a swan to defend a princess. 
So the back of the boats got their first giant swans, which have become one of the icons of Boston.', 8, 1, 'Swan Boats', LOAD_FILE('/boston_art/images/8.jpg')), 
(1, '1951-01-01', 'The Freedom Trail’s red line — in places painted, in places red brick — that snakes through the Revolutionary War historic sites in the heart of Boston is one of those successes 
so big and so obvious in retrospect that it’s easy to take for granted. The Freedom Trail can be seen as a sort of artwork because it’s a giant line drawn through the city — 
but also because it invites acts of psychogeography, exploring the landscape by engaging with its psychological history.', 9, 4, 'Freedom Trail', LOAD_FILE('/boston_art/images/9.jpg')),
(1, '1965-01-01', 'The red and orange triangle in a white square advertising the Venezuelan oil company has long been a signature sight along Boston’s skyline — 
especially as its flashing lights illuminate the city at night. The company says it has had a billboard there since 1940, but the triangle — 
with its echo of Malden-native Frank Stella’s 1960s geometric abstractions — dates to a rebranding in 1965.',10, 4, 'Citgo Sign', LOAD_FILE('/boston_art/images/10.jpg')),
(1, '1972-01-01', 'Named a historic landmark by the city in 2011, the vast concrete space between the century-old cathedral and 
modernist concrete buildings at the Christian Science Plaza feels both meditative and awesome. It’s partly how the buildings seem to embrace the plaza, 
but it’s also how the space is filled by the 
monumental reflecting pool, 690 feet long, 100 feet wide, running parallel to Huntington Avenue.', 11, 4, 'Reflecting Pool', LOAD_FILE('/boston_art/images/11.jpg')), 
(1, '1971-01-01', 'The Rainbow Swash is the common name for an untitled work by Corita Kent in the Dorchester neighborhood of Boston, Massachusetts. 
The rainbow design painted on a 140-foot (43 m) tall LNG storage tank is the largest copyrighted work of art in the world.Highly visible from daily commuters drives on Interstate 93, the landmark is 
considered one of the major landmarks of Boston, akin to the Citgo sign.
 Since the 1970s, the Rainbow Swash has been controversial. The mural was criticized as purportedly featuring a profile of Vietnamese Leader Ho Chi Minh\'s 
 face in its blue stripe. Kent was a peace activist, and some believe 
she was protesting the Vietnam War, but Kent herself always denied embedding such a profile.', 12, 4, 'Rainbow Swash', LOAD_FILE('/boston_art/images/12.jpg')),
(1, '1934-01-01', 'USA Today called it one of the “most quirky landmarks across the USA” in 2014. 
This four-story-tall wood and plaster milk bottle was built by Arthur Gagner in 1934 as an ice cream stand on Route 44 in Taunton. 
After the business closed, one proposal called for placing it on Boston City Hall Plaza. Instead, it was refurbished in red and white in 1977 
by the Hood Milk Company and placed here -- 
operating again as a snack stand, delighting children and becoming a local icon.', 13, 4, 'Giant Milk Bottle', LOAD_FILE('/boston_art/images/13.jpg')),
(1, '1985-01-01', 'Though abstract and industrial-looking, Shingu’s wind-powered artworks are about 
seeking harmony with nature. “Through sculptures and all my activities, I always want to express the same thing,” 
Shingu said in a 2014 profile by the Japan Times. “And that is how lucky are we to be born on this planet — 
a planet that is so beautiful and so delicately balanced.” In “Gift of the Wind,” three red steel sculptures cup the wind, 
rock on their arms, and spin around a 46-foot-tall central post high above the MBTA Red Line station. 
Part of its pleasure is how something so big and 
seemingly heavy is so carefully balanced that it spins so gracefully in the breeze.', 14, 4, 'Gift of the Wind', LOAD_FILE('/boston_art/images/14.jpg')),
(1, '1842-01-01', 'On June 17, 1775, the first major battle of the American Revolution was fought around Bunker Hill and 
— here — Breed’s Hill. In 1794, an 18-foot-tall wooden pillar with a gilt urn was erected on the site. 
Plans began in 1823 to put up something more permanent, but it wasn’t until 1842 that the 221-tall granite obelisk — 
predating the Washington Monument in Washington, D.C., 
and symbolic of the nation’s neoclassical, republican ideals — was completed.', 15, 4, 'Bunker Hill Monument', LOAD_FILE('/boston_art/images/15.jpg')),
(1, '1954-01-01', 'The origins of the monumental, 35-foot-tall statue of Mary standing atop the earth at this Roman Catholic 
shrine trace back to World War II. The Jewish sculptor Arrigo Minerbi had a successful art career in his native Italy until, 
to escape the Holocaust, he went into hiding with the Roman Catholic priests of the Don Orione order of Rome. 
After the war, the order wanted to erect a statue in thanks for the peaceful liberation of Rome from German forces. 
And, Minerbi, in gratitude for the priests’ protection during the conflict, 
designed a monumental statue of Mary, the mother of Jesus, that was erected at the order’s center there in 1953.', 16, 3, 'Madonna Queen of the Universe Shrine', LOAD_FILE('/boston_art/images/16.jpg')),
(1, '2006-01-01', 'The Boston artist snuck his art park bench into Jamaica Pond in May 2006 without approval. 
It looked like all the others, including being anchored to an open concrete pad, 
except it had two backs bending up to meet each other. The surreal change prompted double-takes.', 17, 1, 'Jamaica Pond Bench', LOAD_FILE('/boston_art/images/17.jpg')), 
(1, '2014-01-01', 'As Legoland Discovery Center was being developed, Master Model Builders at 
Legoland Windsor Resort in Britain were busy building a 19-foot-tall yellow giraffe from 22,000 Duplo bricks. 
The critter — the official mascot of Legoland Discovery Centers; they generally each have one somewhere on the 
property — was sent here by cargo ship, and its inner steel frame was anchored four feet into the ground to 
withstand local weather as well as climbing kids. 
Now it’s becoming an advertising landmark — big, yellow and fun.', 18, 2, 'Tessie the Giraffe', LOAD_FILE('/boston_art/images/18.jpg')),
(1, '2013-01-01', '“Nieli’ka are traditional Huichol art — that\'s an indigenous group from west central Mexico, 
from Jalisco, San Luis Potosi and Nayarit — made of yarn… There’s an intense use of color and it’s usually a kind 
of dream image,” explains Heidi Schork, the founder and director of the Mayor’s Mural Crew. “But it’s a nieli’ka in 
Jamaica Plain.” The mural features a brightly colored mask, 
monarch butterfly and blue jay (“a resident of Jamaica Plain, a sort of spirit animal”).', 19, 4, 'Nieli\'ka', LOAD_FILE('/boston_art/images/19.jpg')), 
(1, '2013-01-01', 'Garcia, a Puerto Rican artist and art professor, often adapted the abstract language of 
modernist painting to depict stories and myths from pre-Columbian Puerto Rico. In this mural, he painted bold, 
graphic representations of the Taino legends of the hurricane goddess Guabancex stirring up storms with help 
from the gods Guatauba and Coatrisque. 
They seem to fly across the expanse of the wall like superheroes.', 20, 4, 'Taino Indians', LOAD_FILE('/boston_art/images/20.jpg')),
(1, '2014-01-01', 'The 100-foot-long mural is a statement of pride by and for Roxbury’s African-American community with its black and white portrait of 
Nelson Mandela, 
South Africa’s anti-segregation and anti-apartheid leader who died in 2013, flanked by the slogan “Roxbury love.”', 21, 4, 'Roxbury Love "Mandela"', LOAD_FILE('/boston_art/images/21.jpg')),
(1, '1987-01-01', 'Archimedean Excogitation is a dynamic ball machine sculpture exploring the theme of 
“a new way of seeing.” The sculpture uses visual and kinetic elements to explore how we see and offers 
new ways of looking at the world. This machine includes nearly thirty moving or sound-producing devices 
with two different ball sizes featuring billiard balls in the bottom section and small bowling balls in the top. 
Rising nearly thirty feet into the air, viewers enjoy the sculpture from the ground as balls and devices dance in
 front of them and over their heads. People on the nearby stair landing and balcony can also experience a 
 unique view of the top section’s constellation of moving shapes spinning and twirling around the machine. 
This ball machine was designed by George Rhoads in collaboration with Rock Stream Studios.', 22, 3, 'Archimedean Excogitation', LOAD_FILE('/boston_art/images/22.jpg')),
(1, '1966-01-01', 'Museum of Science Director Bradford Washburn commissioned the 
Louis Paul Jonas Studios to sculpt a Tyrannosaurus rex after seeing the studio’s dinosaur 
sculptures at the 1964 New York World’s Fair. The dinosaur’s head arrived first two years later, 
and was driven around the city on a flatbed truck in an effort to raise money for construction of the 
museum building. The whole creature — standing upright, 20 feet tall and 40 feet long in fiberglass 
over a steel frame — went on display inside the museum in 1972.', 23, 4, 'Tyrannosaurus Rex', LOAD_FILE('/boston_art/images/23.jpg')),
(1, '1887-01-01', 'A ring of cobble stones with a star at the middle marks the site of the Boston Massacre, 
where on March 5, 1770, an argument between American colonists and British troops in tense pre-revolutionary 
Boston got out of hand and resulted in the soldiers shooting and killing five people. Paul Revere, who widely 
circulated his illustrated version of the clash (a knockoff of Henry Pelham’s earlier print), and other revolutionaries 
used the violence to rally people to their cause.', 24, 2, 'Site of the Boston Massacre', LOAD_FILE('/boston_art/images/24.jpg')),
(1, '2000-01-01', 'The 30 metal tubes by the Groton artist (grandson of the famous French painter Henri Matisse, 
and also the creator of “The Kendall Band” chimes at the Kendall Square MBTA stop) ring out a delightful tune 
when struck by metal handles pushed by pedestrians crossing the Charles River Dam. 
After succumbing to weather and use, it was restored to musicality in 2013.', 25, 3, 'Charlestown Bells', LOAD_FILE('/boston_art/images/25.jpg')),
(1, null, 'Phillis Wheatley is hailed as the first African-American, the first American slave and one of the very first American women to publish a book of poetry
 (“Poems on Various Subjects, Religious and Moral,” 1773). That is why she is one of just three women honored
 (along with Abigail Adams and Lucy Stone) with a statue at the “Boston Women’s Memorial” on Boston’s 
 Commonwealth Avenue Mall. But a more riveting monument to Wheatley is this small, nondescript sign on a corner in Chinatown.
The marker is part of the Boston Women’s Heritage Trail, begun in 1989 by Boston public school teachers, librarians and students 
“to restore women to their rightful place in the history of Boston.” ', 26, 1, 'Phillis Wheatley Plaque', LOAD_FILE('/boston_art/images/26.jpg')),
(1, '2014-01-01', 'Inspired by the building owner’s request for a Mexican motif — and a rooster — Heidi Schork,
 the founder and director of the Mayor’s Mural Crew, came up with a catchy graphic composition of flowers and 
 birds around a rooster for this narrow, fenced-off alley sandwiched between two Jamaica Plain buildings. 
 The imagery is inspired by traditional tenangos, which Schork explains are “an embroidered piece of cloth made by 
women in the state of Hidalgo in central Mexico. … Then the cloths are used as hangings.”', 27, 3, 'Tenango', LOAD_FILE('/boston_art/images/27.jpg')),
(1, '2008-01-01', 'After seeing a TV commercial promoting the car dealership run by Robert and Richard Boch, who describe themselves as 
“Super Savers … price slashing superheroes with powers far beyond mortal auto dealers,” artist Kim Giordano approached the brothers with an idea. Giordano — 
who crafts signs, dinosaurs, skull mountains and other sculptures for amusement parks and casinos in his Norfolk shop —proposed he make portrait sculptures of the brothers as supermen. 
They agreed and over the next year or so, 
he painstakingly depicted the Bochs in somewhat-larger-than-life fiberglass over an aluminum frame.', 28, 2, 'Super Saver', LOAD_FILE('/boston_art/images/28.jpg')),
(1, '2002-01-01', 'On the front of the Museum of Modern Renaissance is a mural depicting roosters (“In Slav traditions, it protects you from evil,” Nicholas Shaplyko explains), 
Pisces fish, lilies and a sun-face. In the middle of the painting is a large, carved mask-face, 
with flowers hanging down from a window box above as hair. It all hints at the mysteries inside.', 29, 3, 'Mural façade of the Museum of Modern Renaissance', LOAD_FILE('/boston_art/images/29.jpg')),
(1, '2015-01-01', 'At first glance, the LA artist’s spraycan mural appears to depict a goddess with a paintbrush in one hand and a lightning bolt in the other. 
But the artist’s inspirations were more personal — his father was studying engineering (the lightning) at Northeastern when he met his mother who was enrolled down the street at Massachusetts
 College of Art and Design (the brush). Thus the artist himself is the result of the union of “Ars et Scientia.” 
And the model for the goddess was the El Mac’s own wife, Kim.', 30, 4, 'Ars et Scienta', LOAD_FILE('/boston_art/images/30.jpg')),
(1, '2014-01-01', 'It’s been dubbed the “world’s largest tattoo.” As you walk out on this thousand-foot-long pier into Boston Harbor, under your feet the Somerville artist 
illuminates the cultures local maritime trade has connected with around the world by staining the concrete with a Chinese dragon, an Irish interlace pattern, Japanese waves, swirling graphic 
Maori designs from New Zealand, an English crown and rose, 
a Wampanoag turtle, an Indian peacock, and classic New England ship and mermaid tattoo designs.', 31, 4, 'Connected by Sea', LOAD_FILE('/boston_art/images/31.jpg'));

insert into public_art_has_genre(public_art_id, genre_id) values
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8),
(14, 2),
(15, 4),
(16, 4),
(17, 9),
(18, 4),
(19, 5),
(20, 5),
(21, 5),
(22, 10),
(23, 4),
(26, 11),
(27, 5),
(28, 4),
(29, 3),
(30, 3),
(31, 3);

insert into public_art_has_artist(public_art_id, artist_id) values
(1, 1), 
(2, 2), 
(3, 3), 
(5, 4), 
(7, 5),
(11,6), 
(12, 7),
(13, 8),
(14, 9),
(15, 10), 
(16, 11),
(17,12),
(18,13),
(19,14),
(20,15),
(21,16),
(22,17),
(23,18),
(24,19),
(25,20),
(26,21),
(27,22),
(28,23),
(29,24),
(30,25),
(31,26);